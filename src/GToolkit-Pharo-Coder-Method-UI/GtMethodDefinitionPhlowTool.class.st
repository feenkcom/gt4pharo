Class {
	#name : #GtMethodDefinitionPhlowTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'methodDefinition'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Tool'
}

{ #category : #'instance creation' }
GtMethodDefinitionPhlowTool class >> forMethodDefinition: aMethodDefinition [
	^ self new 	
			methodDefinition: aMethodDefinition
]

{ #category : #'api - converting' }
GtMethodDefinitionPhlowTool >> asElementDo: aBlock [
	| toolContentModel contentElement |
	
	toolContentModel := GtPhlowMultipleViewsToolContentElementModel forPhlowTool: self.
	toolContentModel headerTitleComputation: [ self object printString  ].
	
	contentElement := GtPhlowMultipleViewsContentElement new.
	contentElement toolContentModel: toolContentModel.
	
	^ aBlock cull: contentElement cull: self
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> icon [
	^ BrGlamorousVectorIcons browse
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> methodDefinition [
	^ methodDefinition
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> methodDefinition: aMethodDefinition [
	methodDefinition := aMethodDefinition
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> name [
	^ 'Method'
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> object [
	^ self methodDefinition
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> object: aMethodDefinition [
	self methodDefinition: aMethodDefinition
]

{ #category : #'testing ' }
GtMethodDefinitionPhlowTool >> supportsSelectionHandling [
	"Composite tools know how to extract and restore the selected tool"
	^ true
]

{ #category : #accessing }
GtMethodDefinitionPhlowTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]
