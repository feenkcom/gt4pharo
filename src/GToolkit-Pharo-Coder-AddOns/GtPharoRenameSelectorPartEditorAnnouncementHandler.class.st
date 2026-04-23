Class {
	#name : #GtPharoRenameSelectorPartEditorAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'editor',
		'selectorPartModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> editor [
	^ editor
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> editor: anObject [
	editor := anObject
]

{ #category : #installation }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> install [
	selectorPartModel announcer weak
		when: GtPharoRenameSelectorPartNameChanged
		send: #onRenameSelectorPartNameChanged:
		to: self.

	editor userData at: self class put: self
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> onRenameSelectorPartNameChanged: anAnnouncement [
	editor text: anAnnouncement currentName
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAnnouncementHandler >> selectorPartModel: anObject [
	selectorPartModel := anObject
]
