import QtQuick 2.12
import QtQuick.Window 2.13
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtCharts 2.1
import "controls"
import QtQuick.Shapes 1.14
import QtGraphicalEffects 1.0

Window {
	id : root
	width: 1380
	//maximumWidth : 1280
	//minimumWidth : width
    height: 700
	//maximumHeight : 800
	//minimumHeight : height
	title:"VFD LS IG5a CONTROLLER"
	color :"#141b23" 
    visible: true
    //flags: Qt.WindowMaximized //Qt.Dialog
	
	Text{
	x : 400
	y: 30
	text : "VFD LS IG5a CONTROLLER"
	color : "white"
	font.pixelSize : 35
	}
	
	Text{
	x : 460
	y: 80
	text : "WRITTEN BY : MUHAMMAD HUSNI"
	color : "gold"
	font.pixelSize : 20
	}
	
	Image{
          x : 850
		  y : 10
		  width :130
		  height : 130	  
          source:"ls inverter.png"
		  
		 
		  
	}
	
	
	//gauge
	
	Rectangle{
		x : 30
		y : 20
		width : 300
		height : 650
		color : "transparent"
		border.color : "white"
		border.width : 2
	
	
		
	CircularSlider {
                id: rpm_gauge
				anchors.horizontalCenter: parent.horizontalCenter
                y: 10
				value: 50
                width: 180
                height: 180
				interactive : false
                startAngle: 40
                endAngle: 320
                rotation: 180
                trackWidth: 5
                progressWidth: 20
                minValue: 0
                maxValue: 3000
                progressColor: "white"
                capStyle: Qt.FlatCap

                handle: Rectangle {
                    transform: Translate {
                        x: (rpm_gauge.handleWidth - width) / 2
                        y: rpm_gauge.handleHeight / 2
                    }

                    width: 10
                    height: rpm_gauge.height / 2
                    color: "#FFac89"
                    radius: width / 2
                    antialiasing: true
                }

                Label {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -40
                    rotation: 180
                    font.pointSize: 18
                    color: "#FEFEFE"
                    text: Number(rpm_gauge.value).toFixed()
                }
            }
    
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:180
	text : "RPM"
	color : "white"
	font.pixelSize : 25
	}
	
	
	
			
	CircularSlider {
                id: current_gauge
				anchors.horizontalCenter: parent.horizontalCenter
                y: 220
				value: 4
                width: 180
                height: 180
				interactive : false
                startAngle: 40
                endAngle: 320
                rotation: 180
                trackWidth: 5
                progressWidth: 20
                minValue: 0
                maxValue: 8
                progressColor: "#EB6440"
                capStyle: Qt.FlatCap

                handle: Rectangle {
                    transform: Translate {
                        x: (current_gauge.handleWidth - width) / 2
                        y: current_gauge.handleHeight / 2
                    }

                    width: 10
                    height: current_gauge.height / 2
                    color: "#FFac89"
                    radius: width / 2
                    antialiasing: true
                }

                Label {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -40
                    rotation: 180
                    font.pointSize: 18
                    color: "#FEFEFE"
                    text: Number(current_gauge.value).toFixed(1)
                }
            }
    
	Text{
		anchors.horizontalCenter: parent.horizontalCenter
		y:400
		text : "CURRENT"
		color : "white"
		font.pixelSize : 25
	}	
	
	
	
	CircularSlider {
                id: frequency_gauge
				anchors.horizontalCenter: parent.horizontalCenter
                y: 440
				value: (slider.value).toFixed(1)
                width: 180
                height: 180
				interactive : false
                startAngle: 40
                endAngle: 320
                rotation: 180
                trackWidth: 5
                progressWidth: 20
                minValue: 0
                maxValue: 60
                progressColor: "#00F4FF"
                capStyle: Qt.FlatCap

                handle: Rectangle {
                    transform: Translate {
                        x: (frequency_gauge.handleWidth - width) / 2
                        y: frequency_gauge.handleHeight / 2
                    }

                    width: 10
                    height: frequency_gauge.height / 2
                    color: "#FFac89"
                    radius: width / 2
                    antialiasing: true
                }

                Label {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -40
                    rotation: 180
                    font.pointSize: 18
                    color: "#FEFEFE"
                    text: Number(frequency_gauge.value).toFixed()
                }
            }
      
	Text{
		anchors.horizontalCenter: parent.horizontalCenter
		y:600
		text : "FREQUENCY"
		color : "white"
		font.pixelSize : 25
	}
	
	
	}
	
	//graph
	Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 150
                    width: 650
                    height: 400
					color:"transparent"
					border.color : "white"
					border.width : 2
					
					ChartView {
						id : cv
						antialiasing: true
						legend.visible: false
						height: parent.height
						anchors.right: parent.right
						anchors.left: parent.left
						//theme: ChartView.ChartThemeLight
						backgroundColor:"#141b23"
						property int  timcnt: 0
						property double  valueCH1: 0
						property double  valueCH2: 0
						property double  valueCH3: 0
						property double  valueCH4: 0
						//property double  valueTM1: 0        
						property double  periodGRAPH: 30 // Seconds
						property double  startTIME: 0
						property double  intervalTM: 200 // miliseconds
						
						
						ValueAxis{
						id: axisX
						min: 0
						max: 40
						labelsFont: Qt.font({pointSize: 15})
						titleText:"<font color='white'>Timestamp (ms)"
						color:"white"
						labelsColor: "white"
					}
					
					
					
						ValueAxis{
						id: axisY1
						min: -400
						max: 400
						labelsFont: Qt.font({pointSize: 15})
						titleText:"<font color='white'>Voltage (V)</font>"
						color:"white"
						labelsColor: "white"
					}
					
					
					
						
						
						LineSeries {
						id:lines1
						axisX: axisX
						axisY: axisY1
						width: 4
						color: "red"
						
					}
					
					LineSeries {
						id:lines2
						axisX: axisX
						axisY: axisY1
						width: 4
						color: "blue"
					}
					
					LineSeries {
					
						id:lines3
						axisX: axisX
						axisY: axisY1
						width: 4
						color: "yellow"
					}
					
					
						
				}
			
			}
			
	
	//power limit
	Rectangle{
		x : 1050
		y : 20
		width : 300
		height : 650
		color : "transparent"
		border.color : "white"
		border.width : 2
		
		
		Text{
		anchors.horizontalCenter: parent.horizontalCenter
		y:10
		text : "MODBUS PROPERTIES"
		color : "gold"
		font.pixelSize : 25
		}
		
		
		Text{
		x : 10
		y:90
		text : "MODBUS PORT : "
		color : "white"
		font.pixelSize : 15
		}
		
		
		ComboBox {
			id : cb1
			x : 130
			y : 80
			model: backend.get_port_list_info()
		}
		
		
		Text{
		x : 10
		y:170
		text : "MODBUS SLAVE : "
		color : "white"
		font.pixelSize : 15
		}
		
		
		ComboBox {
			id : cb2
			x : 130
			y : 160
			model : [1,2,3,4,5,6,7,8,9]
		}
		
		
		
		Text{
		x : 10
		y:250
		text : "MODBUS BAUD : "
		color : "white"
		font.pixelSize : 15
		}
		
		
		ComboBox {
			id : cb3
			x : 130
			y : 240
			model : [1200, 2400, 9600, 57600, 115200]
		}
		
		
		Text{
		x : 10
		y:330
		text : "FIRMWARE VER : "
		color : "white"
		font.pixelSize : 15
		}
		
		
		ComboBox {
			id : cb4
			x : 130
			y : 320
			model : ["MAX485","armadillo", "dragon", "capybara", "komodo"]
		}
		
		
	Button{
		id : button1
		anchors.horizontalCenter: parent.horizontalCenter
		y : 400
		width : 220
		height : 50
		text : "CONNECT TO HARDWARE"
		checkable : true
		checked : false
		
		Rectangle {
			id : button1_color
			width : parent.width
			height : parent.height
			color : "#0077b6"
		}
		
	}
		
	
	
	}
	
	Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 560
                    width: 650
                    height: 110
					color:"transparent"
					border.color : "white"
					border.width : 2
		

		Text{
		x : 10
		y : 10
		text : "MOTOR COMMAND : "
		color : "gold"
		font.pixelSize : 20
		}
		
		Slider {
		id : slider
		x: 10
		y: 60
		height : 20
		width : 250
		value: 0
		from: 0
		to: 60
		stepSize : 5
		
	}
	
	
	Slider {
		id : slider_period
		x: 10
		y: 0
		height : 20
		width : 250
		value: -100
		from: -100
		to: 100
		stepSize : 1
		visible : false
		
		Text{
		x : 260
		color : "blue"
		text : slider_period.value
		
		
		}
		
		
	}
	
	Slider {
		id : slider_period2
		x: 30
		y: -30
		height : 20
		width : 250
		value: -100
		from: -100
		to: 100
		stepSize : 1
		visible : false
		Text{
		x : 260
		color : "yellow"
		text : slider_period2.value
		
		
		}
		
	}
	
	
	Text{
		x : 280
		y: 50
		text : (slider.value).toFixed(1) + " Hz"
		color : "white"
		font.pixelSize : 25
		}	
		
		
	Button{
		id : cw
		x : 370
		y : 20
		width : 70
		height : 70
		text : ""
		checkable : true
		checked : false
		
		onClicked:{
			ccw.checked = false
		}
		
		
		Rectangle {
			id : cw_color
			width : parent.width
			height : parent.height
			color : "#0077b6"
			
			Image{
				width : parent.width
				height : parent.height
				source : "CCW.png"
				mirror : true
			}
		}
		
	}


	Button{
		id : run
		x : 460
		y : 20
		width : 70
		height : 70
		text : ""
		checkable : true
		checked : false
		
		
		
		Rectangle {
			id : run_color
			width : parent.width
			height : parent.height
			color : "#0077b6"
			
			Image{
				width : parent.width
				height : parent.height
				source : "run.png"
				mirror : false
			}
		}
		
	}




	Button{
		id : ccw
		x : 550
		y : 20
		width : 70
		height : 70
		text : ""
		checkable : true
		checked : false
		
		onClicked:{
			cw.checked = false
		}
		
		Rectangle {
			id : ccw_color
			width : parent.width
			height : parent.height
			color : "#0077b6"
			
			Image{
				width : parent.width
				height : parent.height
				source : "CCW.png"
				mirror : false
			}
		}
		
	}
	
		
	
	}
	
	
	Timer{
			id:tm
			interval: 10
			repeat: true
			running: true
			onTriggered: {
				backend.update0(cv.series(0));
				backend.update1(cv.series(1));
				backend.update2(cv.series(2));
				
				if (run.checked == true){
					backend.freq(slider.value)
				} else {
					backend.freq(0)
				}
				
				
				backend.period(slider_period.value)
				backend.period2(slider_period2.value)
				
				
				if (cw.checked == true){
					cw_color.color = "#ce4978"
					lines2.color = "yellow"
					lines3.color = "blue"
					
				}
				
				if (cw.checked == false){
					cw_color.color = "#0077b6"
					
				}
				
				if (ccw.checked == true){
					ccw_color.color = "#ce4978"
					lines2.color = "blue"
					lines3.color = "yellow"
					
				}
				
				if (ccw.checked == false){
					ccw_color.color = "#0077b6"
					
				}
				
				
				if (run.checked == true){
					run_color.color = "#ce4978"
					
					
				}
				
				if (run.checked == false){
					run_color.color = "#0077b6"
					
				}
				
				
				}
	  
			}
		
		
	
	
	
	
	
	
	
}













