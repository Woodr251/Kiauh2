#!/bin/bash

#=======================================================================#
# Copyright (C) 2020 - 2022 Dominik Willner <th33xitus@gmail.com>       #
#                                                                       #
# This file is part of KIAUH - Klipper Installation And Update Helper   #
# https://github.com/th33xitus/kiauh                                    #
#                                                                       #
# This file may be distributed under the terms of the GNU GPLv3 license #
#=======================================================================#

set -e

function settings_ui() {
  read_kiauh_ini
  local custom_cfg_loc="${custom_klipper_cfg_loc}"
  local custom_repo="${custom_klipper_repo}"
  local custom_branch="${custom_klipper_repo_branch}"
  local ms_pre_rls="${mainsail_install_unstable}"
  local fl_pre_rls="${fluidd_install_unstable}"

  ### config location
  if [ -z "${custom_cfg_loc}" ]; then
    custom_cfg_loc="${cyan}${KLIPPER_CONFIG}${white}"
  else
    custom_cfg_loc="${cyan}${custom_cfg_loc}${white}"
  fi
  ### custom repository
  custom_repo=$(echo "${custom_repo}" | sed "s/https:\/\/github\.com\///" | sed "s/\.git$//" )
  if [ -z "${custom_repo}" ]; then
    custom_repo="${cyan}Klipper3D/klipper${white}"
  else
    custom_repo="${cyan}${custom_repo}${white}"
  fi
  ### custom repository branch
  if [ -z "${custom_branch}" ]; then
    custom_branch="${cyan}master${white}"
  else
    custom_branch="${cyan}${custom_branch}${white}"
  fi
  ### webinterface stable toggle
  if [ "${ms_pre_rls}" == "false" ]; then
    ms_pre_rls="${red}● ${ms_pre_rls}${white}"
  else
    ms_pre_rls="${green}● ${ms_pre_rls}${white}"
  fi
  if [ "${fl_pre_rls}" == "false" ]; then
    fl_pre_rls="${red}● ${fl_pre_rls}${white}"
  else
    fl_pre_rls="${green}● ${fl_pre_rls}${white}"
  fi

  top_border
  echo -e "|     $(title_msg "~~~~~~~~~~~~ [ KIAUH Settings ] ~~~~~~~~~~~~~")     |"
  hr
  echo -e "| Klipper:                                              |"
  echo -e "|   ● Config folder:                                    |"
  printf  "|     %-60s|\n" "${custom_cfg_loc}"
  echo -e "|   ● Repository:                                       |"
  printf  "|     %-70s|\n" "${custom_repo} (${custom_branch})"
  hr
  echo -e "| Install unstable releases:                            |"
  printf  "|  Mainsail: %-55s|\n" "${ms_pre_rls}"
  printf  "|    Fluidd: %-55s|\n" "${fl_pre_rls}"
  hr
  echo -e "| 1) Change Klipper config folder location              |"
  echo -e "| 2) Set custom Klipper repository                      |"
  if [ "${mainsail_install_unstable}" == "false" ]; then
  echo -e "| 3) ${green}Allow${white} unstable Mainsail releases                   |"
  else
  echo -e "| 3) ${red}Disallow${white} unstable Mainsail releases                |"
  fi
  if [ "${fluidd_install_unstable}" == "false" ]; then
  echo -e "| 4) ${green}Allow${white} unstable Fluidd releases                     |"
  else
  echo -e "| 4) ${red}Disallow${white} unstable Fluidd releases                  |"
  fi
  back_help_footer
}

function show_settings_help(){
  local default_cfg="${cyan}${HOME}/klipper_config${white}"
  top_border
  echo -e "|    ~~~~~~ < ? > Help: KIAUH Settings < ? > ~~~~~~     |"
  hr
  echo -e "| ${cyan}Klipper config folder:${white}                                |"
  echo -e "| The location of your printer.cfg and all other config |"
  echo -e "| files that gets used during installation of Klipper   |"
  echo -e "| and all other components which need that location.    |"
  echo -e "| It is not recommended to change this location.        |"
  echo -e "| Be advised, that negative side effects could occur.   |"
  blank_line
  printf  "| Default: %-55s|\n" "${default_cfg}"
  blank_line
  hr
  echo -e "| ${cyan}Install unstable releases:${white}                            |"
  echo -e "| If set to ${green}true${white}, KIAUH installs/updates the software   |"
  echo -e "| with the latest, currently available release.         |"
  echo -e "| ${yellow}This will include alpha, beta and rc releases!${white}        |"
  blank_line
  echo -e "| If set to ${red}false${white}, KIAUH installs/updates the software  |"
  echo -e "| with the most recent stable release.                  |"
  blank_line
  echo -e "| Default: ${red}false${white}                                        |"
  blank_line
  back_footer
  while true; do
    read -p "${cyan}###### Please select:${white} " choice
    case "${choice}" in
      B|b)
        clear && print_header
        settings_menu
        break;;
      *)
        deny_action "show_settings_help";;
    esac
  done
}

function settings_menu(){
  clear && print_header
  settings_ui
  while true; do
    read -p "${cyan}Perform action:${white} " action; echo
    case "${action}" in
      1)
        change_klipper_cfg_folder && settings_ui;;
      2)
        clear && print_header
        change_klippefunction r_repo_menu
        settings_ui;;
      3)
        switch_mainsail_releasetype && settings_menu;;
      4)
        switch_fluidd_releasetype && settings_menu;;
      B|b)
        clear
        main_menu
        break;;
      H|h)
        clear && print_header
        show_settings_help
        break;;
      *)
        deny_action "settings_ui";;
    esac
  done
}
