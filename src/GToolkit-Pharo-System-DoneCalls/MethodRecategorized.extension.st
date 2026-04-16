Extension { #name : #MethodRecategorized }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
MethodRecategorized >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRecategorizedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass method: self method oldProtocol: self oldProtocol) ]
]
