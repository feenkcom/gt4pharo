"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	announcer:		<Object>


    Implementation Points
"
Class {
	#name : #GtPharoPackagesNavigation2ViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackagesCoderModel + TGtPharoNavigationWithSelectedPackageViewModel',
	#classTraits : 'TGtWithPharoPackagesCoderModel classTrait + TGtPharoNavigationWithSelectedPackageViewModel classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoPackagesNavigation2ViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ]
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigation2ViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtPharoPackagesNavigation2ViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass send: aSelector to: anObject
]
