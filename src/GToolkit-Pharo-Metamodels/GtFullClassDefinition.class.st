Class {
	#name : #GtFullClassDefinition,
	#superclass : #GtBehaviorDefinition,
	#instVars : [
		'classSideDefinition',
		'instanceSideDefinition'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtFullClassDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtFullClassDefinition class >> fromClass: aClass in: anEnvironment [
	^ self new fromClass: aClass in: anEnvironment
]

{ #category : #converting }
GtFullClassDefinition >> asDefinitionString [
	^ self instanceSideDefinition asDefinitionString, '.', String cr, String cr, self classSideDefinition asDefinitionString
]

{ #category : #accessing }
GtFullClassDefinition >> classSideDefinition [
	^ classSideDefinition
]

{ #category : #accessing }
GtFullClassDefinition >> comment [
	<return: #GtCommentDefinition>
	
	^ self instanceSideDefinition comment
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> createChange [
	| aCompositeChange |

	aCompositeChange := (RBCompositeRefactoryChange named: 'Define full class').	
	aCompositeChange addChange: self instanceSideDefinition createChange.
	aCompositeChange addChange: self classSideDefinition createBehaviorChange.
	^ aCompositeChange
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aClass [
	| instRefactorings classRefactorings |
	instRefactorings := (instanceSideDefinition
		difference: aGtCodeDefinitionDifference instanceSideDifference
		toRefactoringsOf: aClass instanceSide) asOrderedCollection.
	classRefactorings := (classSideDefinition
		difference: aGtCodeDefinitionDifference classSideDifference
		toRefactoringsOf: aClass classSide) asOrderedCollection.
	^ instRefactorings , classRefactorings
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aBehavior in: anRBModel [
	| instRefactorings classRefactorings |
	instRefactorings := (instanceSideDefinition
		difference: aGtCodeDefinitionDifference instanceSideDifference
		toRefactoringsOf: aBehavior instanceSide
		in: anRBModel) asOrderedCollection.
	classRefactorings := (classSideDefinition
		difference: aGtCodeDefinitionDifference classSideDifference
		toRefactoringsOf: aBehavior classSide
		in: anRBModel) asOrderedCollection.
	^ instRefactorings , classRefactorings
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> differenceWith: aGtCodeDefinition [
	^ GtFullClassDefinitionDifference new
		instanceSideDifference:
			(instanceSideDefinition
				differenceWith: aGtCodeDefinition instanceSideDefinition);
		classSideDifference:
			(classSideDefinition
				differenceWith: aGtCodeDefinition classSideDefinition);
		yourself
]

{ #category : #initialization }
GtFullClassDefinition >> fromClass: aClass [
	self fromClass: aClass in: self environment
]

{ #category : #initialization }
GtFullClassDefinition >> fromClass: aClass in: anEnvironment [
	self
		assert: [ anEnvironment notNil ]
		description: [ 'Environment must not be nil' ].
	
	self environment: anEnvironment.

	name := aClass name.
	originalName := aClass name.
	
	instanceSideDefinition := (GtClassDefinition fromClass: aClass instanceSide in: anEnvironment) parent: self.
	classSideDefinition := (GtMetaclassDefinition fromMetaclass: aClass classSide in: anEnvironment) parent: self
]

{ #category : #accessing }
GtFullClassDefinition >> instanceSideDefinition [
	^ instanceSideDefinition
]

{ #category : #accessing }
GtFullClassDefinition >> name: aSymbol [
	super name: aSymbol.
	
	self instanceSideDefinition name: aSymbol.
	self classSideDefinition name: aSymbol
]

{ #category : #initialization }
GtFullClassDefinition >> withMethodsFromClass: aClass [
	self instanceSideDefinition withMethodsFromClass: aClass
]
