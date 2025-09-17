Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	<return: #TAsyncPromise>
	^ self gtExecuteWithNotificationThreshold: self gtDefaultBulkExecutionThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationThreshold: aThreshold [
	<return: #TAsyncPromise>
	^ self gtExecuteWithNotificationWithProgress: [  ] threshold: aThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithNotificationWithProgress: aBlock
		threshold: self gtDefaultBulkExecutionThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock threshold: aThreshold [
	<return: #TAsyncPromise>
	| job notification |
	job := self gtCompilationJobWithProgress: aBlock threshold: aThreshold.
	notification := GtNotificationJob new
			summaryClass: GtCompilationNotificationSummary;
			job: job;
			registerNotifications;
			yourself.
	self changesSize > 1
		ifTrue: [ notification showNotifications.
			notification hideNotificationsOnRemoval ].
	^ [ job run ] asAsyncFuture
		await: GtRefactoringsConstants futureExecutionConfiguration
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: aChange [
]
