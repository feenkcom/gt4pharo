Class {
	#name : #GtPharoRenameSelectorParameterLabelAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'parameterModel',
		'label'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #installation }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> install [
	parameterModel announcer weak
		when: GtPharoRenameSelectorParameterNameChanged
		send: #onRenameSelectorParameterNameChanged:
		to: self.

	label userData at: self class put: self
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> label [
	^ label
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> label: anObject [
	label := anObject
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> onRenameSelectorParameterNameChanged: anAnnouncement [
	label text: anAnnouncement currentName
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> parameterModel [
	^ parameterModel
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAnnouncementHandler >> parameterModel: anObject [
	parameterModel := anObject
]
