Class {
	#name : #GtPharoPackageCoderExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'private - set up' }
GtPharoPackageCoderExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #'examples - instance creation' }
GtPharoPackageCoderExamples >> coderOnRegisteredPackage [
	<gtExample>
	<after: #cleanUp>
	| aDummyPackage aPackage aPackageCoder |
	environment := GtPharoDummyEnvironment withPackages: 1 classes: 1.
	aDummyPackage := environment anyDummyPackage.
	aPackage := aDummyPackage realPackage.
	aPackageCoder := GtPharoPackageCoder forPackage: aPackage.
	aPackageCoder attributeNamed: #dummyEnvironment put: environment.
	aPackageCoder attributeNamed: #dummyPackage put: aDummyPackage.
	self assert: aPackageCoder package equals: aPackage.
	self assert: aPackageCoder packageName equals: aPackage name.
	self assert: aPackageCoder isRegistered.
	self
		assert: aPackageCoder classes size
		equals: aDummyPackage amountOfClasses.
	^ aPackageCoder
]

{ #category : #'examples - instance creation' }
GtPharoPackageCoderExamples >> coderOnUnregisteredPackage [
	<gtExample>
	<after: #cleanUp>
	| aDummyPackage aPackage aPackageCoder |

	environment := GtPharoDummyEnvironment withPackages: 1 classes: 0.
	aDummyPackage := environment anyDummyPackage.
	aPackage := aDummyPackage realPackage.
	GtPharoCodeModifier unregisterPackage: aPackage.

	aPackageCoder := GtPharoPackageCoder forPackage: aPackage.
	aPackageCoder attributeNamed: #dummyEnvironment put: environment.
	aPackageCoder attributeNamed: #dummyPackage put: aDummyPackage.

	self assert: aPackageCoder package equals: aPackage.
	self assert: aPackageCoder packageName equals: aPackage name.
	self assert: aPackageCoder isRegistered not.
	self assert: aPackageCoder classes size equals: 0.

	^ aPackageCoder
]

{ #category : #'private - set up' }
GtPharoPackageCoderExamples >> eventsRecorder [
	^ GtCoderExamplesEventsRecorder new
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerPreviouslyUnregisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self unregisterRegisteredPackageWhenSubscribedToSystem.
	aPackageCoder subscribeToSystem.
	
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	[ aPackageCoder register ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered.
	self assert: aPackageCoder classes size equals: (aPackageCoder attributeNamed: #dummyPackage) amountOfClasses.
	"When registering previously unregistered package, its classes are moved back from the unpackaged package to the package itself"
	self assert: (aPackageCoder classes collect: [ :each | each package ]) asSet equals: {  aPackageCoder package } asSet. 

	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageRegistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerRegisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder subscribeToSystem.
	
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	[ aPackageCoder register ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered.
	self assert: anEventsRecoder numberOfEvents equals: 0.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerRegisteredPackageWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnRegisteredPackage.
	
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	aPackageCoder register.

	self assert: aPackageCoder isRegistered.
	self assert: anEventsRecoder numberOfEvents equals: 0.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerUnregisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnUnregisteredPackage.
	aPackageCoder subscribeToSystem.
	
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	[ aPackageCoder register ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered.
	self assert: aPackageCoder classes size equals: 0.

	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageRegistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerUnregisteredPackageWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnUnregisteredPackage.
	
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	aPackageCoder register.

	self assert: aPackageCoder isRegistered.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageRegistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerUnregisteredPackageWithoutCoderWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnUnregisteredPackage.
	aPackageCoder subscribeToSystem.

	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	[ GtPharoCodeModifier registerPackage: aPackageCoder package ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageRegistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package register' }
GtPharoPackageCoderExamples >> registerUnregisteredPackageWithoutCoderWhenUnsubscribedToSystem [
	"The only case when we can not send package registered notification
	is when coder is not subscribed to the system and package is registered directly,
	without coder being involved"
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnUnregisteredPackage.
	aPackageCoder when: GtCoderPackageRegistered send: #record: to: anEventsRecoder.

	GtPharoCodeModifier registerPackage: aPackageCoder package.

	self assert: aPackageCoder isRegistered.
	self assert: anEventsRecoder numberOfEvents equals: 0.
	
	^ aPackageCoder
]

{ #category : #'examples - package rename' }
GtPharoPackageCoderExamples >> renameRegisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder aNewName |
	anEventsRecoder := self eventsRecorder.
	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder subscribeToSystem.
	aPackageCoder
		when: GtCoderPackageRenamed
		send: #record:
		to: anEventsRecoder.
	aNewName := aPackageCoder packageName , 'New'.
	[ aPackageCoder renameTo: aNewName ]
		ensure: [ aPackageCoder unsubscribeFromSystem ].
	self assert: aPackageCoder isRegistered.
	self assert: aPackageCoder packageName equals: aNewName.
	self
		assert: aPackageCoder classes size
		equals: (aPackageCoder attributeNamed: #dummyPackage) amountOfClasses.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self
		assert: anEventsRecoder first class
		equals: GtCoderPackageRenamed.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	^ aPackageCoder
]

{ #category : #'examples - package rename' }
GtPharoPackageCoderExamples >> renameUnloadedPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder aNewName |
	anEventsRecoder := self eventsRecorder.
	aPackageCoder := self unloadRegisteredPackageWhenSubscribedToSystem.
	aPackageCoder subscribeToSystem.
	aPackageCoder
		when: GtCoderPackageRenamed
		send: #record:
		to: anEventsRecoder.
	aNewName := aPackageCoder packageName , 'New'.
	[ aPackageCoder renameTo: aNewName ]
		ensure: [ aPackageCoder unsubscribeFromSystem ].
	self assert: aPackageCoder isRegistered not.
	self assert: aPackageCoder packageName equals: aNewName.
	self assert: aPackageCoder classes size equals: 0.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self
		assert: anEventsRecoder first class
		equals: GtCoderPackageRenamed.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	^ aPackageCoder
]

{ #category : #'examples - package rename' }
GtPharoPackageCoderExamples >> renameUnregisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder aNewName |
	anEventsRecoder := self eventsRecorder.
	aPackageCoder := self coderOnUnregisteredPackage.
	aPackageCoder subscribeToSystem.
	aPackageCoder
		when: GtCoderPackageRenamed
		send: #record:
		to: anEventsRecoder.
	aNewName := aPackageCoder packageName , 'New'.
	[ aPackageCoder renameTo: aNewName ]
		ensure: [ aPackageCoder unsubscribeFromSystem ].
	self assert: aPackageCoder isRegistered not.
	self assert: aPackageCoder packageName equals: aNewName.
	self assert: aPackageCoder classes size equals: 0.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self
		assert: anEventsRecoder first class
		equals: GtCoderPackageRenamed.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	^ aPackageCoder
]

{ #category : #'examples - package rename' }
GtPharoPackageCoderExamples >> renameUnregisteredRegisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder aNewName |
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self unregisterRegisteredPackageWhenSubscribedToSystem.
	aPackageCoder subscribeToSystem.
	aPackageCoder
		when: GtCoderPackageRenamed
		send: #record:
		to: anEventsRecoder.
	aNewName := aPackageCoder packageName , 'New'.
	
	[ aPackageCoder renameTo: aNewName ]
		ensure: [ aPackageCoder unsubscribeFromSystem ].
		
	self assert: aPackageCoder isRegistered not.
	self assert: aPackageCoder packageName equals: aNewName.
	self
		assert: aPackageCoder classes size
		equals: (aPackageCoder attributeNamed: #dummyPackage) amountOfClasses.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self
		assert: anEventsRecoder first class
		equals: GtCoderPackageRenamed.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package unload' }
GtPharoPackageCoderExamples >> unloadRegisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |

	anEventsRecoder := self eventsRecorder.

	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder subscribeToSystem.

	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	[ aPackageCoder unload ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered not.
	"classes are removed from the system when unloading a package"
	self assert: aPackageCoder classes size equals: 0.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageUnregistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package unload' }
GtPharoPackageCoderExamples >> unloadRegisteredPackageWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |

	anEventsRecoder := self eventsRecorder.

	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	aPackageCoder unload.

	self assert: aPackageCoder isRegistered not.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageUnregistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package unregister' }
GtPharoPackageCoderExamples >> unregisterRegisteredPackageWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	anEventsRecoder := self eventsRecorder.

	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder subscribeToSystem.

	aPackageCoder
		when: GtCoderPackageUnregistered
		send: #record:
		to: anEventsRecoder.

	[ aPackageCoder unregister ] ensure: [ aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered not.	"classes are not removed from the system when unregistering package"
	self
		assert: aPackageCoder classes size
		equals: (aPackageCoder attributeNamed: #dummyPackage) amountOfClasses.

	"When unregistering a package with classes, 
	those classes are moved to unpackaged package 
	in the global package organizer."
	self
		assert: (aPackageCoder classes
				collect: [ :each | (self class packageOrganizer packageOf: each) name ])
		equals: {#_UnpackagedPackage} asSet.

	self 
		forPharo12AndNewer: [
			"In Pharo 12 asking the class for a package returns its stored package."
			self
				assert: (aPackageCoder classes 
					collect: [ :each | each package name ]) asSet
				equals: {aPackageCoder packageName} asSet.]
		forPharo11: [	
			"In Pharo 11 asking the class for a package goes through the global
			package organizer, and the package is the unpackaged package."
			self
				assert: (aPackageCoder classes 
					collect: [ :each | each package name ]) asSet
				equals: {#_UnpackagedPackage} asSet].


	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageUnregistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.

	^ aPackageCoder
]

{ #category : #'examples - package unregister' }
GtPharoPackageCoderExamples >> unregisterRegisteredPackageWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	aPackageCoder unregister.

	self assert: aPackageCoder isRegistered not.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageUnregistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package unregister' }
GtPharoPackageCoderExamples >> unregisterRegisteredPackageWithoutCoderWhenSubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder subscribeToSystem.

	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	[ GtPharoCodeModifier unregisterPackage: aPackageCoder package ] ensure: [
		aPackageCoder unsubscribeFromSystem ].

	self assert: aPackageCoder isRegistered not.
	self assert: anEventsRecoder numberOfEvents equals: 1.
	self assert: anEventsRecoder first class equals: GtCoderPackageUnregistered.
	self assert: anEventsRecoder first coder equals: aPackageCoder.
	
	^ aPackageCoder
]

{ #category : #'examples - package unregister' }
GtPharoPackageCoderExamples >> unregisterRegisteredPackageWithoutCoderWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnRegisteredPackage.
	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	self 
		forPharo12AndNewer: [
			aPackageCoder package organizer unregisterPackage: aPackageCoder package ] 
		forPharo11: [
			aPackageCoder package unregister ].

	self assert: aPackageCoder isRegistered not.
	self assert: anEventsRecoder numberOfEvents equals: 0.
	
	^ aPackageCoder
]

{ #category : #'examples - package unregister' }
GtPharoPackageCoderExamples >> unregisterUnregisteredPackageWhenUnsubscribedToSystem [
	<gtExample>
	| aPackageCoder anEventsRecoder |
	
	anEventsRecoder := self eventsRecorder.
	
	aPackageCoder := self coderOnUnregisteredPackage.
	aPackageCoder when: GtCoderPackageUnregistered send: #record: to: anEventsRecoder.

	aPackageCoder unregister.

	self assert: aPackageCoder isRegistered not.
	self assert: anEventsRecoder numberOfEvents equals: 0.
	
	^ aPackageCoder
]
