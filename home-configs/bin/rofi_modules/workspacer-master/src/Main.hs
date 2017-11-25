{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Data.ByteString.Lazy.Char8 (pack)
import Data.Maybe
import Data.List (intercalate)
import Data.Char (toUpper)
import System.Process
import GHC.Generics
import Options.Applicative
import Data.Monoid ((<>))

data Rectangle =
  Rectangle { x :: Int
            , y :: Int
            , width :: Int
            , height :: Int
            }
  deriving (Generic, Show)

data Workspace =
  Workspace { num :: Int
            , name :: String
            , visible :: Bool
            , focused :: Bool
            , rect :: Rectangle
            , output :: String
            , urgent :: Bool
            }
  deriving (Generic, Show)

instance FromJSON Rectangle
instance FromJSON Workspace

getWorkspaces :: String -> [Workspace]
getWorkspaces json
  | isNothing list = []
  | otherwise = fromJust list
  where list = decode (pack json) :: Maybe [Workspace]

getWorkspaceNames :: [Workspace] -> [String]
getWorkspaceNames workspaces = map name workspaces

readWorkspaces :: IO String
readWorkspaces = readProcess "i3-msg" ["-t", "get_workspaces"] ""

openMenu :: [Workspace] -> String -> Options -> IO String
openMenu workspaces title opts = do
  output <- case optMenu opts of
    "rofi" -> readProcess "rofi"
                  ["-width", "30", "-dmenu", "-p", title]
                  menu

    "dmenu" -> readProcess "dmenu" ["-i"] menu

  return (dropWhile (==':') output)

  where menu = intercalate "\n" $ getWorkspaceNames workspaces

setWorkspace :: String -> IO ()
setWorkspace workspace = callCommand ("i3-msg workspace " ++ workspace)

moveContainerTo :: String -> IO ()
moveContainerTo workspace
  = callCommand ("i3-msg move container to workspace " ++ workspace)

runWithOptions :: Options -> IO ()
runWithOptions opts = do
  output <- readWorkspaces

  putStrLn $ show opts

  let workspaces = getWorkspaces output

  case optCommand opts of
    WorkspaceSet -> do
      newWorkspace <- openMenu workspaces "Switch to workspace:" opts
      setWorkspace newWorkspace

    WorkspaceMove -> do
      newWorkspace <- openMenu workspaces "Move container to workspace:" opts
      moveContainerTo newWorkspace

data Command = WorkspaceSet | WorkspaceMove
  deriving (Show)

data Options = Options { optCommand :: Command
                       , optMenu :: String }
  deriving (Show)

withInfo :: Parser a -> String -> ParserInfo a
withInfo opts desc = info (helper <*> opts) $ progDesc desc

optsSet :: Parser Command
optsSet = pure WorkspaceSet

optsMove :: Parser Command
optsMove = pure WorkspaceMove

optsCommand :: Parser Command
optsCommand = subparser
  ( command "set"  (withInfo optsSet "Set the current workspace")
 <> command "move" (withInfo optsMove "Move current container to workspace") )

parseOptions :: Parser Options
parseOptions = Options <$> optsCommand
                       <*> strOption
                           ( long "menu"
                          <> short 'm'
                          <> help "What menu to use"
                          <> showDefault
                          <> value "rofi"
                          <> metavar "MENU" )

main :: IO ()
main = 
  runWithOptions =<<
    execParser (parseOptions `withInfo` "Workspace action menus using i3-msg")

  {- execParser opts >>= runWithOptions -}
  {- where -}
    {- parser = App <$> argument str (metavar "COMMAND") -}
                 {- {- <*> switch (short 'e' <> -} -}
                             {- {- long "excited" <> -} -}
                             {- {- help "Run in excited mode") -} -}
    {- opts = info parser mempty -}
