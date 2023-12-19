"
Provides data for displaying the header of a coder. The target behavioyr is the main behavioyr on which coder was opened. The provider behaviour is the one containing the actual implementation of the method.
"
Class {
	#name : #GtMethodCoderHeaderData,
	#superclass : #Object,
	#instVars : [
		'providerBehaviourName',
		'providerBehaviourIconName',
		'targetBehaviourName',
		'targetBehaviourIconName',
		'packageName'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #testing }
GtMethodCoderHeaderData >> hasProviderBehaviourData [
	^ self providerBehaviourName notNil
]

{ #category : #initialization }
GtMethodCoderHeaderData >> initializeForCoderViewModel: aCoderViewModel [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderData >> packageName [
	^ packageName
]

{ #category : #accessing }
GtMethodCoderHeaderData >> providerBehaviourIconName [
	^ providerBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderData >> providerBehaviourName [
	^ providerBehaviourName
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderData >> spawnBehaviorFor: aCoderViewModel  from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderData >> spawnPackageFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderData >> targetBehaviourIconName [
	^ targetBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderData >> targetBehaviourName [
	^ targetBehaviourName
]
