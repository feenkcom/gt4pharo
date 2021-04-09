Class {
	#name : #GtPharoClassNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoClassCoderModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoClassCoderModel classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoClassNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - pharo class coder model' }
GtPharoClassNavigationViewModel >> onPharoClassCoderModelChanged [
	"Is sent when a new pharoClassCoder model is assigned to the view model"
	
	
]
