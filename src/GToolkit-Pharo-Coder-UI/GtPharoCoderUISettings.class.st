Class {
	#name : #GtPharoCoderUISettings,
	#superclass : #Object,
	#classVars : [
		'IsTraitMethodsFilterDefault'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Settings'
}

{ #category : #testing }
GtPharoCoderUISettings class >> isTraitMethodsFilterDefault [
	^ IsTraitMethodsFilterDefault == true
]

{ #category : #testing }
GtPharoCoderUISettings class >> isTraitMethodsFilterDefault: aBoolean [
	IsTraitMethodsFilterDefault := aBoolean
]
