#!/bin/bash
ip addr show | grep "inet " | grep -v "127.0.0.1" | grep -oE 'inet ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'


