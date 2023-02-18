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



#----------------------------------------------------------------#
voltage = 0
current = 0
power = 0
freq = 0
pf = 1

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
        freq = message
        print(freq)
        
    
    
    
    @pyqtSlot(QObject)
    def update0(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
            series.append(i, (220 * 1.44)*(math.sin((0.0062832 * 50) *i))+ random.random()*8)
            #series.append(i, (voltage * 1.44)*(math.sin(0*i))+ random.random()*8)
            
            
    @pyqtSlot(QObject)
    def update1(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
             series.append(i, (220 * 1.44)*(math.sin((0.0062832 * 50) *((16)-i)))+ random.random()*8)
            #series.append(i, (current * 1.44)*(math.sin((0.0062832 * freq) *((1-i) - (pf*10)))))
    
    
    @pyqtSlot(QObject)
    def update2(self, series):
        series.clear()
        for i in range(80):
            #series.append(i, (voltage * 1.44)*(math.sin(0.31416*i))+ random.random()*8)
             series.append(i, (220 * 1.44)*(math.sin((0.0062832 * 50) *(4-i)))+ random.random()*8)
            #series.append(i, (current * 1.44)*(math.sin((0.0062832 * freq) *((1-i) - (pf*10)))))
            
    

        
#----------------------------------------------------------------#

########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    
    
    
    main = table()
    
    
#----------------------------------------------------------------#