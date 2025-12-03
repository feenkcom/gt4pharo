Class {
	#name : #GtRestorePreviousLocalVersionExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#instVars : [
		'environment'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-UI'
}

{ #category : #cleanup }
GtRestorePreviousLocalVersionExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #utils }
GtRestorePreviousLocalVersionExamples >> disableEpiceaDuring: aBlockClosure [
	^ EpMonitor disableDuring: [
		aBlockClosure value ] 
]

{ #category : #examples }
GtRestorePreviousLocalVersionExamples >> methodWithLocalVersions [
	| targetClass dummyMethod targetMethod |
	<gtExample>
	<after: #cleanUp>

	environment := GtPharoDummiesGenerator new
		amountOfPackages: 1;
		amountOfClasses: 1;
		amountOfMethods: 1;
		generate.

	dummyMethod := environment anyDummyUnaryMethod.
	targetClass := dummyMethod realClass.
	
	self disableEpiceaDuring: [
		targetClass compile: dummyMethod selector, '
	^ 1' classified: 'generated'.
		targetClass compile: dummyMethod selector,'
	^ 2' classified: 'generated' ] . 
	
	targetMethod := targetClass >> dummyMethod selector.
	self assert: targetMethod gtChangeRecords size equals: 3.
	self assert: targetMethod gtLocalVersions size equals: 3.
	
	targetMethod gtLocalVersions do: [ :each |
		self assert: each timeStamp notNil.
		self assert: each timeStamp ~= DateAndTime new. ].
	
	self 
		assert: (targetMethod methodClass >> targetMethod selector) sourceCode
		equals: (targetMethod selector, '
	^ 2').

	^ targetMethod
]

{ #category : #examples }
GtRestorePreviousLocalVersionExamples >> restoreMethodToOldVersion [
	| targetMethod scripter |
	<gtExample>

	targetMethod := self methodWithLocalVersions.
	scripter := self scripterWithElement: [
		(targetMethod gtLocalVersionsFor: GtPhlowView empty) asElement ].
	
	scripter clickStep: [:aStep |
		aStep
			label: 'Expand second version';
			id: (BlElementId named: #sidebar) index: 2 ].
	
	self disableEpiceaDuring: [
		scripter clickStep: [:aStep |
			aStep
				label: 'Accept version';
				id: BlLocalVersionAcceptVersionButtonId ] ].
			
	self 
		assert: (targetMethod methodClass >> targetMethod selector) sourceCode
		equals: (targetMethod selector, '
	^ 1').
	
	targetMethod gtLocalVersions do: [ :each |
		self assert: each timeStamp notNil.
		self assert: each timeStamp ~= DateAndTime new. ].

	^ scripter.
]
