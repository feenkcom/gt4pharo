"
Provides data for displaying the header of a coder. The target behavioyr is the main behavioyr on which coder was opened. The provider behaviour is the one containing the actual implementation of the method.
"
Class {
	#name : #GtMethodCoderHeaderModel,
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
GtMethodCoderHeaderModel >> hasProviderBehaviourData [
	^ self providerBehaviourName notNil
]

{ #category : #initialization }
GtMethodCoderHeaderModel >> initializeForCoderViewModel: aCoderViewModel [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> packageName [
	^ packageName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> providerBehaviourIconName [
	^ providerBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> providerBehaviourName [
	^ providerBehaviourName
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnBehaviorFor: aCoderViewModel  from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> targetBehaviourIconName [
	^ targetBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> targetBehaviourName [
	^ targetBehaviourName
]
