Class {
	#name : #GtPharoCoderSettings,
	#superclass : #Object,
	#classVars : [
		'IsTraitMethodsFilterDefault'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Settings'
}

{ #category : #testing }
GtPharoCoderSettings class >> isTraitMethodsFilterDefault [
	^ IsTraitMethodsFilterDefault == true
]

{ #category : #testing }
GtPharoCoderSettings class >> isTraitMethodsFilterDefault: aBoolean [
	IsTraitMethodsFilterDefault := aBoolean
]
