#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2023 Roland.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
import os
import numpy as np
from gnuradio import gr, blocks
import pmt

class customFileSink(gr.sync_block):
    def __init__(self):
        gr.sync_block.__init__(self,
            name="customFileSink",
            in_sig=[np.complex64],
            out_sig=None
            )
        self.message_port_register_in(pmt.intern('message'))
        self.set_msg_handler(pmt.intern('message'), self.handle_msg)
        self.selector = 0
        self.record_state = False
        self.folder_path = '/home/roland23/gr-OotTask/'
        self.file = None
        self.file_index = 1

    # Handler for incoming messages
    def handle_msg(self, msg):
        messg = pmt.to_python(msg)
        value = int(messg[-1])
        self.selector += value
        self.selector %= 2
        print(self.selector)

    # Opens a new file for writing
    def open_file(self):
        if not self.record_state:
            print("Opening a file")
            while True:
                file_name = f"{self.file_index}.raw"
                file_path = os.path.join(self.folder_path, file_name)
                if not os.path.exists(file_path):
                    try:
                        self.file = open(file_path, 'wb')
                    except FileNotFoundError:
                        print("Directory does not exist")
                        return
                    print(f"New file '{file_name}' is created & opened")
                    self.record_state = True
                    break
                self.file_index += 1

    # Closes the currently opened file
    def close_file(self):
        if self.record_state:
            self.file.close()
            print("File is closed")
            self.record_state = False

    # Main working function
    def work(self, input_items, output_items):
        
        start = self.nitems_read(0)
        stop = start + len(input_items[0])
        
        tags = self.get_tags_in_range(0, start, stop)
        for tag in tags:
            key = tag.key
            value = pmt.symbol_to_string(tag.value)
            if value=='start':
                self.selector = 1
            else:
                self.selector = 0

        if self.selector:  # Button pressed
            self.open_file()
        else:  # Button released
            self.close_file()
        
        if self.record_state:
            # print("Recording")
            inbuf = input_items[0].tobytes()
            try:
                self.file.write(inbuf)
            except:
                print("An error occurred while writing to the file")

        return len(input_items[0])
