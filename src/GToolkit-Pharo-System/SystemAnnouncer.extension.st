Extension { #name : #SystemAnnouncer }

{ #category : #'*GToolkit-Pharo-System' }
SystemAnnouncer >> prevent: anAnnouncementClass during: aBlock [
	"This method allows one to ensure that an Announcement class or an AnnouncementSet will never be announced during the execution of a single-threaded block.
	One of the goal can be for example to allow to send messages that should announce something without doing the announcement multiple times while letting the other announcements pass through."

	SystemAnnouncerPreventing 
		value: self preventedAnnouncements copy, anAnnouncementClass
		during: aBlock.
]

{ #category : #'*GToolkit-Pharo-System' }
SystemAnnouncer >> preventedAnnouncements [

	^ SystemAnnouncerPreventing value
]
