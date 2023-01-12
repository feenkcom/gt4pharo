Class {
	#name : #GtVariableDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'originalName',
		'name',
		'binding'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtVariableDefinition class >> fromClassVariable: aClassVariable [
	^ self new fromClassVariable: aClassVariable
]

{ #category : #'instance creation' }
GtVariableDefinition class >> named: aName [
	^ self new named: aName
]

{ #category : #converting }
GtVariableDefinition >> asDefinitionString [
	^ self name printString
]

{ #category : #initialization }
GtVariableDefinition >> fromClassVariable: aClassVariable [
	name := aClassVariable name asSymbol.
	originalName := name.
	binding := aClassVariable
]

{ #category : #testing }
GtVariableDefinition >> isValidName [
	^ RBScanner isVariable: self name
]

{ #category : #accessing }
GtVariableDefinition >> name [
	^ name
]

{ #category : #accessing }
GtVariableDefinition >> name: anObject [
	name := anObject
]

{ #category : #initialization }
GtVariableDefinition >> named: aName [
	name := aName.
	originalName := aName
]

{ #category : #accessing }
GtVariableDefinition >> originalName [
	^ originalName
]

{ #category : #accessing }
GtVariableDefinition >> originalName: anObject [
	originalName := anObject
]

{ #category : #accessing }
GtVariableDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	name := name copy.
	originalName := originalName copy.
]

{ #category : #printing }
GtVariableDefinition >> printOn: aStream [
	aStream print: self name
]

{ #category : #accessing }
GtVariableDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'name:';
		space;
		store: self name.
	aStream
		nextPut: $)
]

{ #category : #accessing }
GtVariableDefinition >> value [
	^ binding value
]
