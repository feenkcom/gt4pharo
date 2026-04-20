Class {
	#name : #GtPharoRenameSelectorKeywordEditorAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'editor',
		'keywordModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> editor [
	^ editor
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> editor: anObject [
	editor := anObject
]

{ #category : #installation }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> install [
	keywordModel announcer weak
		when: GtPharoRenameSelectorKeywordNameChanged
		send: #onRenameSelectorKeywordNameChanged:
		to: self.

	editor userData at: self class put: self
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> keywordModel [
	^ keywordModel
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> keywordModel: anObject [
	keywordModel := anObject
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorKeywordEditorAnnouncementHandler >> onRenameSelectorKeywordNameChanged: anAnnouncement [
	editor text: anAnnouncement currentName
]
