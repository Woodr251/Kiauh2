#!/usr/bin/env python3

# ======================================================================= #
#  Copyright (C) 2020 - 2023 Dominik Willner <th33xitus@gmail.com>        #
#                                                                         #
#  This file is part of KIAUH - Klipper Installation And Update Helper    #
#  https://github.com/dw-0/kiauh                                          #
#                                                                         #
#  This file may be distributed under the terms of the GNU GPLv3 license  #
# ======================================================================= #

import textwrap

from kiauh.core.menus import BACK_FOOTER
from kiauh.core.menus.base_menu import BaseMenu
from kiauh.modules.klipper import klipper_setup
from kiauh.modules.mainsail.menus.mainsail_remove_menu import MainsailRemoveMenu
from kiauh.modules.moonraker.menus.moonraker_remove_menu import MoonrakerRemoveMenu
from kiauh.utils.constants import COLOR_RED, RESET_FORMAT


# noinspection PyMethodMayBeStatic
class RemoveMenu(BaseMenu):
    def __init__(self):
        super().__init__(
            header=True,
            options={
                1: self.remove_klipper,
                2: MoonrakerRemoveMenu,
                3: MainsailRemoveMenu,
                5: self.remove_fluidd,
                6: self.remove_klipperscreen,
                7: self.remove_crowsnest,
                8: self.remove_mjpgstreamer,
                9: self.remove_pretty_gcode,
                10: self.remove_telegram_bot,
                11: self.remove_obico,
                12: self.remove_octoeverywhere,
                13: self.remove_mobileraker,
                14: self.remove_nginx,
            },
            footer_type=BACK_FOOTER,
        )

    def print_menu(self):
        header = " [ Remove Menu ] "
        color = COLOR_RED
        count = 62 - len(color) - len(RESET_FORMAT)
        menu = textwrap.dedent(
            f"""
            /=======================================================\\
            | {color}{header:~^{count}}{RESET_FORMAT} |
            |-------------------------------------------------------|
            | INFO: Configurations and/or any backups will be kept! |
            |-------------------------------------------------------|
            | Firmware & API:           | Webcam Streamer:          |
            |  1) [Klipper]             |  6) [Crowsnest]           |
            |  2) [Moonraker]           |  7) [MJPG-Streamer]       |
            |                           |                           |
            | Klipper Webinterface:     | Other:                    |
            |  3) [Mainsail]            |  8) [PrettyGCode]         |
            |  4) [Fluidd]              |  9) [Telegram Bot]        |
            |                           | 10) [Obico for Klipper]   |
            | Touchscreen GUI:          | 11) [OctoEverywhere]      |
            |  5) [KlipperScreen]       | 12) [Mobileraker]         |
            |                           | 13) [NGINX]               |
            |                           |                           |
            """
        )[1:]
        print(menu, end="")

    def remove_klipper(self):
        klipper_setup.run_klipper_setup(install=False)

    def remove_fluidd(self):
        print("remove_fluidd")

    def remove_fluidd_config(self):
        print("remove_fluidd_config")

    def remove_klipperscreen(self):
        print("remove_klipperscreen")

    def remove_crowsnest(self):
        print("remove_crowsnest")

    def remove_mjpgstreamer(self):
        print("remove_mjpgstreamer")

    def remove_pretty_gcode(self):
        print("remove_pretty_gcode")

    def remove_telegram_bot(self):
        print("remove_telegram_bot")

    def remove_obico(self):
        print("remove_obico")

    def remove_octoeverywhere(self):
        print("remove_octoeverywhere")

    def remove_mobileraker(self):
        print("remove_mobileraker")

    def remove_nginx(self):
        print("remove_nginx")
