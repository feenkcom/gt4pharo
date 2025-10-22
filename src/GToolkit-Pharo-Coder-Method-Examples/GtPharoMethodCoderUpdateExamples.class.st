Class {
	#name : #GtPharoMethodCoderUpdateExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoMethodCoderUpdateExamples >> collapsedMethodCoderChangeMethodAndCheckCollapsedText [
	<gtExample>
	| aScripter aNewMethod aCoder |
	aNewMethod := GtPharoCoderMockedClass >> #instanceMethodC.

	aScripter := self collapsedMethodCoderCheckCollapsedText.
	aCoder := aScripter userData at: #coder.

	aScripter do
		label: 'Change compiled method';
		block: [ aCoder forMethod: aNewMethod ];
		play.

	aScripter
		assertStep: [ :s | 
			s
				id: GtSourceCoderCollapsedTextId;
				value: [ :aLabel | aLabel text asString ]
					equals: [ aNewMethod selector asString ] ].

	^ aScripter
]

{ #category : #examples }
GtPharoMethodCoderUpdateExamples >> collapsedMethodCoderChangeMethodAndCheckCollapsedText_nonUIProcess [
	<gtExample>
	| aScripter aNewMethod aCoder |
	aNewMethod := GtPharoCoderMockedClass >> #instanceMethodC.

	aScripter := self collapsedMethodCoderCheckCollapsedText.
	aCoder := aScripter userData at: #coder.

	aScripter do
		label: 'Change compiled method';
		block: [ :anElement | 
			| aPromise |
			aPromise := [ aCoder forMethod: aNewMethod ] asAsyncFuture
					await: GtCoderModel commonExecutionConfiguration.
			anElement enqueueTask: (BlPromiseTask new promise: aPromise) ];
		play.

	aScripter
		assertStep: [ :s | 
			s
				id: GtSourceCoderCollapsedTextId;
				value: [ :aLabel | aLabel text asString ]
					equals: [ aNewMethod selector asString ] ].

	^ aScripter
]

{ #category : #examples }
GtPharoMethodCoderUpdateExamples >> collapsedMethodCoderCheckCollapsedText [
	<gtExample>
	| aMethod aCoder aCoderViewModel aCoderElement aScripter |
	aMethod := GtPharoCoderMockedClass >> #instanceMethodA.
	aCoder := GtPharoMethodCoder forMethod: aMethod.
	aCoderViewModel := aCoder asCoderViewModel.
	aCoderViewModel
		collapse;
		withoutHeader.
	aCoderElement := aCoderViewModel asElement.

	aScripter := BlScripter new.
	aScripter set
		key: #coder value: [ aCoder ];
		play.
	aScripter set
		key: #coderViewModel value: [ aCoderViewModel ];
		play.
	aScripter element: aCoderElement.

	aScripter
		assertStep: [ :s | 
			s
				id: GtSourceCoderCollapsedTextId;
				value: [ :aLabel | aLabel text asString ]
					equals: [ aMethod selector asString ] ].

	^ aScripter
]
