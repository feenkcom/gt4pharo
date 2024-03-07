Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	^ self gtExecuteWithNotificationWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock [
	| job notification |
	job := self gtCompilationJobWithProgress: aBlock.
	notification := GtCompilationNotificationJob new.
	notification job: job.
	notification registerNotifications.
	^ [ job run ] asAsyncPromise
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: aChange [
]
