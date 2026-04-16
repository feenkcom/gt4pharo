Extension { #name : #MethodRecategorized }

{ #category : #'*GToolkit-Pharo-System' }
MethodRecategorized >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRecategorizedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass method: self method oldProtocol: self oldProtocol) ]
]
