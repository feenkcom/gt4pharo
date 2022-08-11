Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	| job notification |
	job := self gtCompilationJob.
	notification := GtNotificationJob new.
	notification job: job.
	^ [ job run ] asAsyncPromise
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: aChange [
]
