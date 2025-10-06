"
I notify that {{gtMethod:GtRefactoringsViewModel >> refactorings:}} should be updated.
I am used:
- to confirm that some refactorings can be computed (and then previewed), see {{gtMethod:GtRefactoringsWithInputViewModel >> refactoringsForInput:}},
- to update refactorings based on a user input, see {{gtMethod:GtRefactoringsWithConfirmationViewModel>>#confirmRefactorings}}. 

"
Class {
	#name : #GtRefactoringsViewModelSubmitExecutedRefactoringsRequested,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}
