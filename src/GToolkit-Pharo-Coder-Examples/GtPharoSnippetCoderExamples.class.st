Class {
	#name : #GtPharoSnippetCoderExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> selfBinding [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'self'.
	aCoderViewModel selfObject: 42.

	self assert: aCoderViewModel doIt value equals: 42.
	self assert: aCoderViewModel behavior equals: SmallInteger.
	
	^ aCoderViewModel
]

{ #category : #'instance creation' }
GtPharoSnippetCoderExamples >> snippetCoder [
	<gtExample>
	| aSnippetCoder |

	aSnippetCoder := GtPharoSnippetCoder forSource: '(self ifNil: [ 0 ] ifNotNil: [ :aNumber | aNumber - 2 ]) = 40'.

	self assert: aSnippetCoder behavior equals: UndefinedObject.

	^ aSnippetCoder
]

{ #category : #examples }
GtPharoSnippetCoderExamples >> snippetCoderDefaultDestinationExample [
	<gtExample>
	| snippetCoder |
	snippetCoder := self snippetCoder.
	
	self assert: snippetCoder spawnDestination isSpawnNextPane.
	
	^ snippetCoder
]

{ #category : #examples }
GtPharoSnippetCoderExamples >> snippetCoderDestinationChangeExample [
	<gtExample>
	| snippetCoder |
	snippetCoder := self snippetCoderDefaultDestinationExample.
	
	snippetCoder spawnDestination: GtPhlowSpawnBelowDestination new.
	self assert: snippetCoder spawnDestination isSpawnBelow.
	
	^ snippetCoder
]

{ #category : #'instance creation' }
GtPharoSnippetCoderExamples >> snippetCoderViewModel [
	<gtExample>
	| aCoder aCoderViewModel expectedBindings |

	aCoder := self snippetCoder.
	aCoderViewModel := aCoder asCoderViewModel.

	expectedBindings := GtCompositeVariablesBindings new.
	expectedBindings addBindings: GtReservedVariablesBindings new.
	expectedBindings addBindings: GtGlobalVariablesBindings new.
	expectedBindings addBindings: (GtLocalVariablesBindings new
		localAt: #thisCoder put: aCoder;
		localAt: #thisCoderViewModel put: aCoderViewModel).
	expectedBindings addBindings: GtSharedVariablesBindings new.

	self assert: aCoderViewModel selfObject equals: nil.
	self assert: aCoderViewModel compositeVariableBindings equals: expectedBindings.
	self assert: aCoderViewModel behavior equals: UndefinedObject.

	^ aCoderViewModel
]

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> superBinding [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'super class'.
	aCoderViewModel selfObject: 42.

	self assert: aCoderViewModel doIt value equals: SmallInteger.
	self assert: aCoderViewModel behavior equals: SmallInteger.
	
	^ aCoderViewModel
]

{ #category : #examples }
GtPharoSnippetCoderExamples >> syntaxError [
	<gtExample>
	^ GtPharoSnippetCoder new
		forSource: '3 + - 4';
		yourself
]

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> thisCoderBinding [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'thisCoder'.

	self assert: aCoderViewModel doIt value equals: aCoderViewModel coderModel.

	^ aCoderViewModel
]

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> thisCoderViewModelBinding [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'thisCoderViewModel'.

	self assert: aCoderViewModel doIt value equals: aCoderViewModel.

	^ aCoderViewModel
]

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> thisContextBinding [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'thisContext'.

	self assert: (aCoderViewModel doIt value method methodClass includesBehavior: UndefinedObject).

	^ aCoderViewModel
]

{ #category : #'examples - bindings' }
GtPharoSnippetCoderExamples >> withoutSelfObject [
	<gtExample>
	| aCoderViewModel |
	
	aCoderViewModel := self snippetCoderViewModel.
	aCoderViewModel coderModel forSource: 'self'.
	aCoderViewModel selfObject: nil.
	
	self assert: aCoderViewModel doIt value equals: nil.
	self assert: aCoderViewModel behavior equals: UndefinedObject.

	^ aCoderViewModel
]
