Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtDiffElementClass [
	^ GtUserActivatableChangeWithExpanderElement
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	<return: #TAsyncPromise>
	^ self gtExecuteWithNotificationThreshold: self gtDefaultBulkExecutionThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationIn: anElement [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithNotificationThreshold: self gtDefaultBulkExecutionThreshold
		in: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationThreshold: aThreshold [
	<return: #TAsyncPromise>
	^ self gtExecuteWithNotificationWithProgress: [  ] threshold: aThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationThreshold: aThreshold in: anElement [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithNotificationWithProgress: [  ]
		threshold: aThreshold
		in: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithNotificationWithProgress: aBlock
		threshold: self gtDefaultBulkExecutionThreshold
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock in: anElement [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithNotificationWithProgress: aBlock
		threshold: self gtDefaultBulkExecutionThreshold
		in: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock threshold: aThreshold [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithProgress: aBlock
		threshold: aThreshold
		registeringNotification: [ :aNotification | aNotification registerNotifications ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: aBlock threshold: aThreshold in: anElement [
	<return: #TAsyncPromise>
	^ self
		gtExecuteWithProgress: aBlock
		threshold: aThreshold
		registeringNotification: [ :aNotification | aNotification registerNotificationsIn: anElement ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithProgress: aBlock threshold: aThreshold registeringNotification: aRegistrationBlock [
	<return: #TAsyncPromise>
	| job notification |
	job := self gtCompilationJobWithProgress: aBlock threshold: aThreshold.
	notification := GtNotificationJob new
			summaryClass: GtCompilationNotificationSummary;
			job: job;
			yourself.
	aRegistrationBlock value: notification.
	self changesSize > 1
		ifTrue: [ notification showNotifications.
			notification hideNotificationsOnRemoval ].
	^ [ job run ] asAsyncFuture
		await: GtRefactoringsConstants futureExecutionConfiguration
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: aChange [
]
