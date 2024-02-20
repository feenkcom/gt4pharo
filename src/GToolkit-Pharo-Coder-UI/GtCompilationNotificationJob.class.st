Class {
	#name : #GtCompilationNotificationJob,
	#superclass : #GtNotificationJob,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtCompilationNotificationJob >> registerNotifications [
	GtWorld allInstancesDo: [ :world | world showNotification: self ]
]

{ #category : #accessing }
GtCompilationNotificationJob >> summaryClass [
	^ GtCompilationNotificationSummary
]
