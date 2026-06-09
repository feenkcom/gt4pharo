Class {
	#name : #GtFixItAdviceModel,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-Support'
}

{ #category : #initialization }
GtFixItAdviceModel >> initialize [
	super initialize.
	
	announcer := Announcer new.
]

{ #category : #'api - notifying' }
GtFixItAdviceModel >> notifyShowFixItDropdown [
	announcer
		announce: (GtFixItAdviceModelShowDropdownAnnouncement new model: self)
]

{ #category : #'api - subscriptions' }
GtFixItAdviceModel >> when: anAnnouncementClass send: aSelector to: aReceiver [
	^ announcer weak
		when: anAnnouncementClass
		send: aSelector
		to: aReceiver
]
