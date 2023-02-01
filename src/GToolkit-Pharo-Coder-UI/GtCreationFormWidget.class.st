Class {
	#name : #GtCreationFormWidget,
	#superclass : #BrFrame,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'onAccept',
		'form',
		'onElementCreated'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms'
}

{ #category : #'instance creation' }
GtCreationFormWidget class >> forBaseline [
	^ self forForm: GtBaselineCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forClass [
	^ self forForm: GtClassCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forForm: aDescription [
	^ self new form: aDescription
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forPackage [
	^ self forForm: GtPackageCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forParser [
	^ self forForm: GtParserCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forTrait [
	^ self forForm: GtTraitCreationForm new
]

{ #category : #converting }
GtCreationFormWidget >> createForm [
	self
		addChild: (self form
				onAccept: self onAccept;
				onElementCreated: self onElementCreated) asElement
]

{ #category : #accessing }
GtCreationFormWidget >> form [

	^ form
]

{ #category : #accessing }
GtCreationFormWidget >> form: anObject [
	form := anObject.
	self removeChildren.
	self createForm
]

{ #category : #initialization }
GtCreationFormWidget >> initialize [
	super initialize.

	onAccept := [ :aValue | self phlow spawnObject: aValue ].
	onElementCreated := [ :aFrame |  ].
	self layout: BlFlowLayout vertical.
	self margin: (BlInsets all: 5).
	self
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical fitContent ]
]

{ #category : #accessing }
GtCreationFormWidget >> onAccept [

	^ onAccept
]

{ #category : #accessing }
GtCreationFormWidget >> onAccept: anObject [
	onAccept := anObject.
	self removeChildren.
	self createForm
]

{ #category : #accessing }
GtCreationFormWidget >> onElementCreated [
	^ onElementCreated
]

{ #category : #accessing }
GtCreationFormWidget >> onElementCreated: anObject [
	onElementCreated := anObject.
	self removeChildren.
	self createForm
]
