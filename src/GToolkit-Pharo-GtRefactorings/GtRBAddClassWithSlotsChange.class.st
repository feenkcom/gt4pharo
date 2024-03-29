Class {
	#name : #GtRBAddClassWithSlotsChange,
	#superclass : #RBAddClassChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #private }
GtRBAddClassWithSlotsChange class >> definitionPatterns [
	^ #('`@superclass subclass: `#className uses: `@traitExpression slots: `@slotsExpression classVariables: `@classVariableSlots poolDictionaries: `#poolDictionaries package: `#category'
	'`@superclass subclass: `#className slots: `@slotsExpression classVariables: `@classVariableSlots poolDictionaries: `#poolDictionaries package: `#category'
	'`@superclass subclass: `#className uses: `@traitExpression slots: `@slotsExpression classVariables: `@classVariableSlots package: `#category'
	'`@superclass subclass: `#className slots: `@slotsExpression classVariables: `@classVariableSlots package: `#category')
		flatCollect: [ :each | 
			Array
				with: each
				with:
					(each copyReplaceAll: '`@superclass' with: 'ProtoObject')
						, '. `className superclass: `@superclass' ]
]
