Class {
	#name : #GtPharoMethodCoderBigMethodExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> aBigMethod [
	"Answer a method which is guaranteed to be larger than minBigMethodSize"
	| bigMethod source compiler |

	"If #reduceTable is large enough, use it."
	bigMethod := GtBigMethodTestClass >> #reduceTable.
	bigMethod sourceCode size > self minBigMethodSize ifTrue: [ ^ bigMethod ].

	"Otherwise compile a method that is large enough"
	source := (String streamContents: [ :stream |
		stream
			<< 'theBigMethod'; lf;
			lf;
			<< '^ ''';
			<< (String loremIpsum: self minBigMethodSize);
			nextPut: $' ]).
	compiler := self class compiler
		source: source;
		class: self class;
		requestor: nil;
		failBlock: [ self error: 'Unable to create a big method' ];
		permitUndeclared: false;
		protocol: #anything;
		changeStamp: 'not needed';
		logged: false.
	EpMonitor disableDuring:
		[ bigMethod := compiler install.
		bigMethod methodClass: self class. ].
		
	^ bigMethod
]

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> coderOnMethod: aMethod [
	<gtExample>
	| aCoder |
	aCoder := GtPharoMethodCoder new.
	aCoder forMethod: aMethod.
	^ aCoder
]

{ #category : #examples }
GtPharoMethodCoderBigMethodExamples >> exampleBigMethod [
	<gtExample>
	<after: #removeABigMethod>
	| method coder scripter |

	method := self aBigMethod.
	self assert: method isBigMethod
		description: 'Test method is no longer big'.
	coder := self coderOnMethod: method.
	scripter := self scripterForBlock: [ coder asCoderViewModel ].

	scripter assertStep: [ :s |
		s
			label: 'Confirm read-only editor';
			// GtSourceCoderEditorId;
			// GtSourceCoderEditorInnerId;
			@ [ :each | each viewModel mode class = BrTextEditorReadonlyWithSelectionMode ] ].

	scripter assertStep: [ :s |
		s
			label: 'Confirm remove button is present';
			// #'main-action--remove' ].

	scripter assertStep: [ :s |
		s
			label: 'Confirm save button is absent';
			notExists;
			// #'main-action--save' ].

	^ scripter
]

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> minBigMethodSize [
	"Answer the minimum number of bytes required in a big method.
	Note that this may be overridden at customer sites."

	^ 10000
]

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> removeABigMethod [

	(self class lookupSelector: #theBigMethod) ifNotNil: [ :method |
		EpMonitor disableDuring:
			[ method removeFromSystem ] ].
]

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> scripter [
	| scripter |
	scripter := BlScripter new.
	
	self assert: scripter events isEmpty.
	
	^ scripter
]

{ #category : #utilities }
GtPharoMethodCoderBigMethodExamples >> scripterForBlock: aBlock [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter substep: 'Initialize Coder Model and UI' do: [ :aStep | 
		aStep set 
			label: 'Initialize Coder Model';
			model: aBlock;
			play.
		aStep set 
			label: 'Initialize Coder UI';
			element: [ :aCoder | aCoder asExpandedOnlyElement ];
			onModel;
			play ].

	^ aScripter
]
