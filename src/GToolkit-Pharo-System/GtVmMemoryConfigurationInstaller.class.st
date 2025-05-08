Class {
	#name : #GtVmMemoryConfigurationInstaller,
	#superclass : #Object,
	#instVars : [
		'activeConfiguration',
		'configurationsRegistry',
		'enabled',
		'dataThresholds'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #'as yet unclassified' }
GtVmMemoryConfigurationInstaller class >> default [ 
	^ default ifNil: [
		default := self new ]
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> apply: aMemoryConfiguration during: aComputationBlock when: aBoolean [
	self isEnabled ifFalse: [ ^ aComputationBlock value ].
	aBoolean ifFalse: [ ^ aComputationBlock value ].
	
	activeConfiguration ifNotNil: [
		self inform: 'Memory configuration already active!'.
		^ aComputationBlock value ].
	
	^ [
		activeConfiguration := aMemoryConfiguration.
		aMemoryConfiguration activeDuring: aComputationBlock
	] ensure: [
		activeConfiguration := nil ]
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> applyForLargeObjectAllocationsDuring: aComputationBlock [
	^ self 
		applyForLargeObjectAllocationsDuring: aComputationBlock 
		when: true
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> applyForLargeObjectAllocationsDuring: aComputationBlock methodSourcesSize: aNumber [

	^ self 
		applyForLargeObjectAllocationsDuring: aComputationBlock 
		when: (self 
			dataThresholdAt: #methodSourcesSize 
			above: aNumber)
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> applyForLargeObjectAllocationsDuring: aComputationBlock when: aBoolean [
	^ self 
		applyWithId: #forLargeObjectAllocation  
		during: aComputationBlock 
		when: aBoolean
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> applyWithId: aMemoryConfigurationId during: aComputationBlock when: aBoolean [
	| currentMemoryConfiguration |
	self isEnabled ifFalse: [ ^ aComputationBlock value ].
	aBoolean ifFalse: [ ^ aComputationBlock value ].
	
	currentMemoryConfiguration := configurationsRegistry
		configurationWithId: aMemoryConfigurationId 
		ifAbsent: [ ^ aComputationBlock value ].
	
	^ self 
		apply: currentMemoryConfiguration 
		during: aComputationBlock 
		when: aBoolean
]

{ #category : #configuring }
GtVmMemoryConfigurationInstaller >> configurationBuilderWithId: anId put: anObject [ 
	configurationsRegistry builderWithId: anId put: anObject 
]

{ #category : #api }
GtVmMemoryConfigurationInstaller >> dataThresholdAt: aString above: aValue [
	^ self 
		dataThresholdAt: aString 
		ifPresent: [ :each | aValue > each thresholdValue ] 
		ifAbsent: [ false ]
]

{ #category : #accessing }
GtVmMemoryConfigurationInstaller >> dataThresholdAt: aString ifAbsent: anAbsentBlock [
	^ dataThresholds at: aString ifAbsent: anAbsentBlock
]

{ #category : #accessing }
GtVmMemoryConfigurationInstaller >> dataThresholdAt: aString ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ dataThresholds at: aString ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #configuring }
GtVmMemoryConfigurationInstaller >> dataThresholdAt: aString put: aValue [ 
	dataThresholds at: aString put: aValue 
]

{ #category : #configuring }
GtVmMemoryConfigurationInstaller >> disable [
	enabled := false.
]

{ #category : #configuring }
GtVmMemoryConfigurationInstaller >> enable [
	enabled := true.
]

{ #category : #views }
GtVmMemoryConfigurationInstaller >> gtConfigurationBuildersFor: aView [
	<gtView>
	^(aView forward)
		title: 'Configuration Builders';
		object: [configurationsRegistry];
		view: #gtConfigurationsBuildersByIdFor:
]

{ #category : #views }
GtVmMemoryConfigurationInstaller >> gtDataThresholdsFor: aView [
	<gtView>
	
	^aView columnedList
		title: 'Data Thresholds';
		priority: 1;
		items: [ dataThresholds associations ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value description ] weight: 3;
		send: [ :assoc | assoc value  ].
		
]

{ #category : #initialization }
GtVmMemoryConfigurationInstaller >> initialize [
	super initialize.
	
	enabled := false.
	configurationsRegistry := GtVmMemoryConfigurationRegistry new.
	dataThresholds := Dictionary new.
	
	self initializeForLargeObjectAllocationsConfiguration.
	self initializeMethodSourcesSizeThreshold.
]

{ #category : #initialization }
GtVmMemoryConfigurationInstaller >> initializeForLargeObjectAllocationsConfiguration [
	self 
		configurationBuilderWithId: #forLargeObjectAllocation 
		put: [GtVmMemoryManagement forLargeObjectAllocation].
]

{ #category : #initialization }
GtVmMemoryConfigurationInstaller >> initializeMethodSourcesSizeThreshold [
	self 
		dataThresholdAt: #methodSourcesSize 
		put: (GtVmMemoryConfigurationBytesMemoryThreshold new 
			thresholdValue: 5* 1024 * 1024) "5 MiB"
]

{ #category : #testing }
GtVmMemoryConfigurationInstaller >> isEnabled [
	^ enabled ifNil: [ false ]
]
