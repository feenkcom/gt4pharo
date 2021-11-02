Class {
	#name : #GtPharoExampleSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel + TGtPharoWithSubscribedMethodsCoderModel + TGtAnnouncer',
	#classTraits : 'TGtPharoSuiteViewModel classTrait + TGtPharoWithSubscribedMethodsCoderModel classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'executor'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> allStates [

	^ GtFilterExampleState default allStates
]

{ #category : #announcer }
GtPharoExampleSuiteViewModel >> announcer [

	^ announcer
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beLocalFrom: aSource [

	self executor: GtPharoLocalExampleSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> beRemoteFrom: aSource [

	self executor: GtPharoRemoteExampleSuiteExecutor new
]

{ #category : #'api - suite' }
GtPharoExampleSuiteViewModel >> executor: anExecutor [

	executor := anExecutor.
	self notifyCodersCoderChanged
]

{ #category : #accessing }
GtPharoExampleSuiteViewModel >> initialize [

	super initialize.

	announcer := Announcer new.
	executor := GtPharoLocalExampleSuiteExecutor new
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> notifyCodersCoderChanged [

	"Notify one or more method coders changed"
	
	self announce: GtPharoSuiteViewModelChanged new
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> onCodersCoderExampleExecuted: aGtCoderExampleExecuted [

	self notifyCodersCoderChanged
]

{ #category : #'api - methods coder model' }
GtPharoExampleSuiteViewModel >> subscribeExtraToCodersCoder: aMethodCoder [

	aMethodCoder weak
		when: GtCoderExampleExecuted
		send: #onCodersCoderExampleExecuted:
		to: self
]
