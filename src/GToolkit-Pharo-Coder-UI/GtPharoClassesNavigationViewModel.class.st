Class {
	#name : #GtPharoClassesNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoClassesCoderModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoClassesCoderModel classTrait',
	#instVars : [
		'announcer',
		'classViewModels',
		'selectedClassViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoClassesNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - pharo classes coder model' }
GtPharoClassesNavigationViewModel >> onPharoClassesCoderModelChanged [
	"Is sent when a new pharoClassesCoder model is assigned to the view model"
	
	classViewModels := nil.
	
	selectedClassViewModel := nil
]
