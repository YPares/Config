ARDUINO_DIR = /opt/arduino
BOARD_TAG = diecimila
BOARD_SUB = atmega328

include /usr/local/share/arduino/Arduino.mk

check-syntax:
	$(CXX) -c -include Arduino.h -x c++ $(CXXFLAGS) $(CPPFLAGS) -fsyntax-only $(CHK_SOURCES)
