#!/usr/bin/env python3


import gi
gi.require_version("Gtk", "3.0")

import dbus
import logging
import os
import psutil
import setproctitle
import subprocess
import sys
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import Gio, GLib, Gtk
from Xlib import display, protocol, X, Xatom

def format_label(label):
    return str(label).replace("_", "")

class EWMH:
    """This class provides the ability to get and set properties defined
    by the EWMH spec. It was blanty ripped out of pyewmh
      * https://github.com/parkouss/pyewmh
    """

    def __init__(self, _display=None, root = None):
        self.display = _display or display.Display()
        self.root = root or self.display.screen().root

    def getActiveWindow(self):
        """Get the current active (toplevel) window or None (property _NET_ACTIVE_WINDOW)

        :return: Window object or None"""
        active_window = self._getProperty('_NET_ACTIVE_WINDOW')
        if active_window == None:
            return None

        return self._createWindow(active_window[0])

    def _getProperty(self, _type, win=None):
        if not win:
            win = self.root
        atom = win.get_full_property(self.display.get_atom(_type), X.AnyPropertyType)
        if atom:
            return atom.value

    def _setProperty(self, _type, data, win=None, mask=None):
        """Send a ClientMessage event to the root window"""
        if not win:
            win = self.root
        if type(data) is str:
            dataSize = 8
        else:
            data = (data+[0]*(5-len(data)))[:5]
            dataSize = 32

        ev = protocol.event.ClientMessage(window=win, client_type=self.display.get_atom(_type), data=(dataSize, data))

        if not mask:
            mask = (X.SubstructureRedirectMask|X.SubstructureNotifyMask)
        self.root.send_event(ev, event_mask=mask)

    def _createWindow(self, wId):
        if not wId:
            return None
        return self.display.create_resource_object('window', wId)


"""
  format_label_list
"""
def format_label_list(label_list):
  head, *tail = label_list
  result = head
  for label in tail:
    result = result + " > " + label
  result = result.replace("Root > ", "")
  result = result.replace("_", "")
  return result

"""
  try_appmenu_interface
"""
def try_appmenu_interface(window_id):
  # --- Get Appmenu Registrar DBus interface
  session_bus = dbus.SessionBus()
  appmenu_registrar_object = session_bus.get_object('com.canonical.AppMenu.Registrar', '/com/canonical/AppMenu/Registrar')
  appmenu_registrar_object_iface = dbus.Interface(appmenu_registrar_object, 'com.canonical.AppMenu.Registrar')

  # --- Get dbusmenu object path
  try:
    dbusmenu_bus, dbusmenu_object_path = appmenu_registrar_object_iface.GetMenuForWindow(window_id)
  except dbus.exceptions.DBusException:
    return

    # --- Access dbusmenu items
  dbusmenu_object = session_bus.get_object(
    dbusmenu_bus, dbusmenu_object_path)
  dbusmenu_object_iface = dbus.Interface(
    dbusmenu_object, 'com.canonical.dbusmenu')
  dbusmenu_level_1_items = dbusmenu_object_iface.GetLayout(
    0, -1, ["label", "children-display"])

  dbusmenu_item_dict = dict()

  """ expanse_all_menu_with_dbus """
  def expanse_all_menu_with_dbus(item, root):
    item_id = item[0]
    item_props = item[1]

    # expand if necessary
    if 'children-display' in item_props:
      if len(item[2]) == 0:
        #print("rerouting")
        dbusmenu_object_iface.AboutToShow(item_id)
      item = dbusmenu_object_iface.GetLayout(item_id, -1, ["label", "children-display"])[1]

    item_children = item[2]

    if 'label' in item_props and not root:
      if len(item_children) == 0:
        me = {format_label(item_props['label']): item_id}
      else:
        child_list = {}
        for child in item_children:
          ret = expanse_all_menu_with_dbus(child, False)
          if ret:
            child_list.update(ret)
        me = {format_label(item_props['label']): child_list}
    else:
      if len(item_children) != 0:
        child_list = {}
        for child in item_children:
          child_list.update(expanse_all_menu_with_dbus(child, False))
        return child_list
      return
    return me

  expanse_all_menu_with_dbus(dbusmenu_level_1_items[1], True)

  dbusmenu_items = dbusmenu_object_iface.GetLayout(0, -1, ["label"])


  #For excluding items which have no action
  blacklist = []

  """ explore_dbusmenu_item """
  def explore_dbusmenu_item(item, label_list):
    item_id = item[0]
    item_props = item[1]

    item_children = item[2]

    if 'label' in item_props:
      new_label_list = label_list + [item_props['label']]
    else:
      new_label_list = label_list

    if len(item_children) == 0:
      if new_label_list not in blacklist:
        dbusmenu_item_dict[format_label_list(new_label_list)] = item_id
    else:
      blacklist.append(new_label_list)
      for child in item_children:
        explore_dbusmenu_item(child, new_label_list)

  explore_dbusmenu_item(dbusmenu_items[1], [])

  #print(dbusmenu_item_dict)

  menuKeys = sorted(dbusmenu_item_dict.keys())

  # --- Run rofi/dmenu
  menu_string = ''
  head, *tail = menuKeys
  menu_string = head
  for m in tail:
    menu_string += '\n'
    menu_string += m

  menu_cmd = subprocess.Popen(['rofi', '-dmenu', '-i',
                                  '-p', 'HUD: ',
                                  '-columns', '2'
                                  '-location', '4',
                                  '-width', '100',
                                  '-lines', '20',
                                  '-fixed-num-lines'
                                  '-separator-style', 'solid',
                                  '-hide-scrollbar'],
                                  stdout=subprocess.PIPE, stdin=subprocess.PIPE)
  menu_cmd.stdin.write(menu_string.encode('utf-8'))
  menu_result = menu_cmd.communicate()[0].decode('utf8').rstrip()
  menu_cmd.stdin.close()

  if menu_result.endswith("\n"):
    menu_result = menu_result[:-1]

  # --- Use menu result
  if menu_result in dbusmenu_item_dict:
    action = dbusmenu_item_dict[menu_result]
    dbusmenu_object_iface.Event(action, 'clicked', 0, 0)


"""
  try_gtk_interface
"""
def try_gtk_interface(gtk_bus_name, gtk_menu_object_path, gtk_app_object_path):

  # --- Ask for menus over DBus ---
  session_bus = dbus.SessionBus()

  gtk_menu_object = session_bus.get_object(gtk_bus_name, gtk_menu_object_path)
  gtk_menu_object_iface = dbus.Interface(gtk_menu_object, dbus_interface='org.gtk.Menus')
  gtk_menu_results = gtk_menu_object_iface.Start([x for x in range(1024)])
  gtk_menu_object_actions_iface = dbus.Interface(gtk_menu_object, dbus_interface='org.gtk.Actions')

  connection = Gio.bus_get_sync(Gio.BusType.SESSION, None)
  menu_action_group = Gio.DBusActionGroup.get(connection, gtk_bus_name, gtk_menu_object_path)
  #print(menu_action_group.list_actions())


  if (gtk_app_object_path is not None):
    gtk_app_object = session_bus.get_object(gtk_bus_name, gtk_app_object_path)
    gtk_app_object_actions_iface = dbus.Interface(gtk_app_object, dbus_interface='org.gtk.Actions')
    app_action_group = Gio.DBusActionGroup.get(connection, gtk_bus_name, gtk_app_object_path)

  # --- Construct menu list ---
  gtk_menubar_menus = dict()
  for gtk_menu_result in gtk_menu_results:
    gtk_menubar_menus[(gtk_menu_result[0], gtk_menu_result[1])] = gtk_menu_result[2]

  gtk_menubar_action_dict = dict()
 # gtk_menubar_target_dict = dict()

  """ explore_menu """
  def explore_menu(menu_id, label_list):
    if menu_id in gtk_menubar_menus:
      for menu in gtk_menubar_menus[menu_id]:
        if 'label' in menu:
          menu_label = menu['label']
          new_label_list = label_list + [menu_label]
          formatted_label = format_label_list(new_label_list)

          if 'action' in menu:
            menu_action = menu['action']
            if ':section' not in menu and ':submenu' not in menu:
              gtk_menubar_action_dict[formatted_label] = menu_action
            # if 'target' in menu:
             # menu_target = menu['target']
             # gtk_menubar_target_dict[formatted_label] = menu_target

        if ':section' in menu:
          menu_section = menu[':section']
          section_menu_id = (menu_section[0], menu_section[1])
          explore_menu(section_menu_id, label_list)

        if ':submenu' in menu:
          menu_submenu = menu[':submenu']
          submenu_menu_id = (menu_submenu[0], menu_submenu[1])
          explore_menu(submenu_menu_id, new_label_list)

  explore_menu((0,0), [])

  menuKeys = sorted(gtk_menubar_action_dict.keys())

  # --- Run rofi/dmenu
  menu_string = ''
  head, *tail = menuKeys
  menu_string = head
  for m in tail:
    menu_string += '\n'
    menu_string += m


  menu_cmd = subprocess.Popen(['rofi', '-dmenu', '-i',
                                  '-p', 'HUD: ',
                                  '-columns', '2'
                                  '-location', '4',
                                  '-width', '100',
                                  '-lines', '20',
                                  '-fixed-num-lines'
                                  '-separator-style', 'solid',
                                  '-hide-scrollbar'],
                                  stdout=subprocess.PIPE, stdin=subprocess.PIPE)
  menu_cmd.stdin.write(menu_string.encode('utf-8'))
  menu_result = menu_cmd.communicate()[0].decode('utf8').rstrip()
  menu_cmd.stdin.close()

  if menu_result.endswith("\n"):
    menu_result = menu_result[:-1]

  # --- Use menu result
  if menu_result in gtk_menubar_action_dict:
    action = gtk_menubar_action_dict[menu_result]
    # print('GTK Action :', action)
    action = action.split(".",1)[1]

    try:
      menu_action_group.activate_action(action, None)
      #gtk_menu_object_actions_iface.Activate(action, [], dict())
    except:
      pass

    try:
      app_action_group.activate_action(action, None)
      #gtk_app_object_actions_iface.Activate(action, [], dict())
    except:
      pass

  gtk_menu_object_iface.End([x for x in range(1024)])
  try:
    gtk_app_object_iface.End([x for x in range(1024)])
  except:
    pass

##################################################
##  main
##################################################

# Get Window properties and GTK MenuModel Bus name
ewmh = EWMH()
win = ewmh.getActiveWindow()
window_id = hex(ewmh._getProperty('_NET_ACTIVE_WINDOW')[0])
window_pid = ewmh._getProperty('_NET_WM_PID', win)[0]
prompt = psutil.Process(window_pid).name() + ': '
gtk_bus_name = ewmh._getProperty('_GTK_UNIQUE_BUS_NAME', win)
gtk_menu_object_path = ewmh._getProperty('_GTK_MENUBAR_OBJECT_PATH', win)
gtk_app_object_path = ewmh._getProperty('_GTK_APPLICATION_OBJECT_PATH', win)
# print('Window id is : %s', window_id)
# print('Window pid is : %s', window_pid)
# print('Prompt is : %s', prompt)
# print('_GTK_UNIQUE_BUS_NAME: %s', gtk_bus_name)
# print('_GTK_MENUBAR_OBJECT_PATH: %s', gtk_menu_object_path)
# print('_GTK_APPLICATION_OBJECT_PATH: %s', gtk_app_object_path)


if (not gtk_bus_name) or (not gtk_menu_object_path):
  try_appmenu_interface(int(window_id, 16))
elif (not gtk_app_object_path):
  try_gtk_interface(gtk_bus_name, gtk_menu_object_path, None)
else:
  try_gtk_interface(gtk_bus_name, gtk_menu_object_path, gtk_app_object_path)
