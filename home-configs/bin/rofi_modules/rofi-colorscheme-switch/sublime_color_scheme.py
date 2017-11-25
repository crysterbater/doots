import sublime
import plistlib
import os
 
PACKAGES_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
 
class SublimeColorScheme(object):
    """Class to load colors from sublime theme"""
 
    def __init__(self):
        self.load_color_theme()
        self.observe_settings()
 
    def observe_settings(self):
        settings = sublime.load_settings('Preferences.sublime-settings')
        settings.clear_on_change('observe_color_scheme')
        settings.add_on_change('observe_color_scheme', self.load_color_theme)
 
    def load_color_theme(self):
        prefs = sublime.load_settings('Preferences.sublime-settings')
        color_scheme = os.path.join(PACKAGES_DIR, prefs.get('color_scheme'))
        property_list = plistlib.readPlist(color_scheme)['settings']
        self.color_scheme = [element for element in property_list if 'name' not in element][0]['settings']
 
    def get_color(self, name, default = '#FFFFFF'):
        if name not in self.color_scheme:
            return default;
        return self.color_scheme[name]
 
colors = SublimeColorScheme()
