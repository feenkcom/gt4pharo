Extension { #name : #RBClass }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBClass >> asClassWithTrait [
	"Hack to add a trait expression variable to the class"

	| classWithTrait |
	classWithTrait := GtRBClassWithTrait new.
	1 to: self class instSize do: [ :i | classWithTrait instVarAt: i put: (self instVarAt: i) ].
	
	(model changedClasses includesKey: self name)
		ifTrue: [ (model changedClasses at: self name) at: 1 put: classWithTrait ]
		ifFalse: [ (model newClasses at: self name) at: 1 put: classWithTrait ].
	
	^ classWithTrait
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBClass >> gtDefinitionString [
	^ String
		streamContents: [ :definitionStream | 
			definitionStream
				nextPutAll: self superclass name;
				nextPutAll: ' subclass: #';
				nextPutAll: self name.
			self traitExpression
				ifNotNil: [ :exp | 
					definitionStream
						nextPutAll: '
	uses: ';
						nextPutAll: exp ].
			definitionStream
				nextPutAll: '
	instanceVariableNames: '''.
			self instanceVariableNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll: '''
	classVariableNames: '''.
			self classVariableNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll: '''
	poolDictionaries: '''.
			self sharedPoolNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll: '''
	category: #'''.
			definitionStream nextPutAll: self category asString.
			definitionStream nextPut: $' ]
]
