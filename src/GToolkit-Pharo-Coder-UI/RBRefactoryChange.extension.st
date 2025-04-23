Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	^ self gtExecuteWithNotificationWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock [
	| job notification |
	job := self gtCompilationJobWithProgress: aBlock.
	notification := GtNotificationJob new
			summaryClass: GtCompilationNotificationSummary;
			job: job;
			registerNotifications;
			yourself.
	self changesSize > 1
		ifTrue: [ notification showNotifications.
			notification hideNotificationsOnRemoval ].
	^ [ job run ] asAsyncPromise
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: aChange [
]
