Extension { #name : #MethodAnnouncement }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
MethodAnnouncement >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodAnnouncementDone
		asClassIfPresent: [ :anAnnouncementClass | 
			| anAnnouncement |
			[ anAnnouncement := anAnnouncementClass new method: self method; yourself ] onErrorDo: [ :anException | ^ self ].
			anAnnouncer announce: anAnnouncement ]
]
