Extension { #name : #ClassCommented }

{ #category : #'*GToolkit-Pharo-System' }
ClassCommented >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassCommentedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass
				class: self classAffected
				oldComment: self oldComment
				newComment: self newComment
				oldStamp: self oldStamp
				newStamp: self newStamp) ]
]
