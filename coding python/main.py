######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
import sys

import math
import random

import serial
#----------------------------------------------------------------#

port = []

def serial_ports():
    
    if sys.platform.startswith('win'):
        ports = ['COM%s' % (i + 1) for i in range(256)]
    elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
        # this excludes your current terminal "/dev/tty"
        ports = glob.glob('/dev/tty[A-Za-z]*')
    elif sys.platform.startswith('darwin'):
        ports = glob.glob('/dev/tty.*')
    else:
        raise EnvironmentError('Unsupported platform')

    result = []
    for port in ports:
        try:
            s = serial.Serial(port)
            s.close()
            result.append(port)
        except (OSError, serial.SerialException):
            pass
    return result
print((serial_ports()))
port = serial_ports()


#----------------------------------------------------------------#
voltage = 0
current = 0
power = 0
freq = 0
pf = 1
phase_shift = 0
phase_shift2 = 0

########## mengisi class table dengan instruksi pyqt5#############
#----------------------------------------------------------------#
class table(QObject):    
    def __init__(self, parent = None):
        super().__init__(parent)
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine(self)
        self.engine.rootContext().setContextProperty("backend", self)    
        self.engine.load(QUrl("main.qml"))
        sys.exit(self.app.exec_())
    
    @pyqtSlot(result=QVariant)
    def get_port_list_info(self):
        return serial_ports()
    
    @pyqtSlot(result=int)
    def get_tiempo(self):
        date_time = QDateTime.currentDateTime()
        unixTIME = date_time.toSecsSinceEpoch()
        #unixTIMEx = date_time.currentMSecsSinceEpoch()
        return unixTIME
    
    @pyqtSlot(result=float)
    def voltage(self):  return voltage
    
    @pyqtSlot(result=float)
    def current(self):  return current
    
    @pyqtSlot(int)
    def freq(self, message):
        global freq
        global period
        freq = message
        
        
    @pyqtSlot(int)
    def period(self, message):
        global freq
        global phase_shift
        #phase_shift = message
        
        if (freq == 5):
            phase_shift = 45
        
        if (freq == 10):
            phase_shift = -74.2857
            
        if (freq == 15):
            phase_shift =  16.190476
            
        if (freq == 20):
            phase_shift = -89.52
            
        if (freq == 25):
            phase_shift = -30.47 
            
        if (freq == 30):
            phase_shift = -60
            
            
        if (freq == 35):
            phase_shift = -79.04
            
        if (freq == 40):
            phase_shift = -70
            
        if (freq == 45):
            phase_shift = -63
        
        if (freq == 50):
            phase_shift = -75.238095
        
        if (freq == 55):
            phase_shift = -70.4761
            
        if (freq == 60):
            phase_shift = -80
            
        
        
        
        print(phase_shift)
        
        
    @pyqtSlot(int)
    def period2(self, message):
        global phase_shift2
        #phase_shift2 = message

        
        if (freq == 5):
            phase_shift2 = -62
            
        if (freq == 10):
            phase_shift2 = 65.714
            
        if (freq == 15):
            phase_shift2 = -84.74619
            
        if (freq == 20):
            phase_shift2 = -12.38095
            
        if (freq == 25):
            phase_shift2 = -46.666
            
        if (freq == 30):
            phase_shift2 = -41.9
            
            
        if (freq == 35):
            phase_shift2 = -33.3333
            
        if (freq == 40):
            phase_shift2 = -29.52
            
        if (freq == 45):
            phase_shift2 = -25.71
        
        if (freq == 50):
            phase_shift2 = -23.8095
        
        if (freq == 55):
            phase_shift2 = -22
            
        if (freq == 60):
            phase_shift2 = -20
        
        
    @pyqtSlot(QObject)
    def update0(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
            series.append(i, (220 * 1.44)*(math.sin((0.0062832 * freq) * i))+ random.random()*8)
            #series.append(i, (voltage * 1.44)*(math.sin(0*i))+ random.random()*8)
            
            
    @pyqtSlot(QObject)
    def update1(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
             series.append(i, (220 * 1.44)*(math.sin((0.0062832 * freq) *((phase_shift)-i)))+ random.random()*8)
            #series.append(i, (current * 1.44)*(math.sin((0.0062832 * freq) *((1-i) - (pf*10)))))
    
    
    @pyqtSlot(QObject)
    def update2(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
             series.append(i, (220 * 1.44)*(math.sin((0.0062832 * freq) *((phase_shift2)-i)))+ random.random()*8)
            #series.append(i, (current * 1.44)*(math.sin((0.0062832 * freq) *((1-i) - (pf*10)))))
            
    

        
#----------------------------------------------------------------#

########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    
    
    
    main = table()
    
    
#----------------------------------------------------------------#