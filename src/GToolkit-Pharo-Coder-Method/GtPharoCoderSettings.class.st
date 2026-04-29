Class {
	#name : #GtPharoCoderSettings,
	#superclass : #Object,
	#classVars : [
		'DisplayNewRenameImplementationContextMenuItem',
		'IsTraitMethodsFilterDefault'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Settings'
}

{ #category : #settings }
GtPharoCoderSettings class >> displayNewRenameImplementationContextMenuItem [
	^ DisplayNewRenameImplementationContextMenuItem == true
]

{ #category : #settings }
GtPharoCoderSettings class >> displayNewRenameImplementationContextMenuItem: aBoolean [
	DisplayNewRenameImplementationContextMenuItem := aBoolean
]

{ #category : #settings }
GtPharoCoderSettings class >> isTraitMethodsFilterDefault [
	^ IsTraitMethodsFilterDefault == true
]

{ #category : #settings }
GtPharoCoderSettings class >> isTraitMethodsFilterDefault: aBoolean [
	IsTraitMethodsFilterDefault := aBoolean
]
