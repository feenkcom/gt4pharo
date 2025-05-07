Class {
	#name : #GtVmMemoryConfigurationRegistry,
	#superclass : #Object,
	#instVars : [
		'configurationsBuildersById'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #adding }
GtVmMemoryConfigurationRegistry >> builderWithId: anId put: anObject [ 
	configurationsBuildersById at: anId put: anObject 
]

{ #category : #api }
GtVmMemoryConfigurationRegistry >> configurationWithId: anId ifAbsent: anAbsentBlock [
 	^ configurationsBuildersById 
 		at: anId 
 		ifPresent: [ :each | each value ]
 		ifAbsent: anAbsentBlock
]

{ #category : #views }
GtVmMemoryConfigurationRegistry >> gtConfigurationsBuildersByIdFor: aView [
	<gtView>
	^(aView forward)
		title: 'Configuration Builders';
		object: [configurationsBuildersById];
		view: #gtItemsFor:
]

{ #category : #initialization }
GtVmMemoryConfigurationRegistry >> initialize [
	super initialize.

	configurationsBuildersById := Dictionary new.
	self 
		builderWithId: #forLargeObjectAllocation 
		put: [GtVmMemoryManagement forLargeObjectAllocation]
]
