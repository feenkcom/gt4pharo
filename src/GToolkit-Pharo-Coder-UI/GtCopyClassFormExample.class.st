Class {
	#name : #GtCopyClassFormExample,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #examples }
GtCopyClassFormExample >> copyClassMethodEvents [
	"Ensure that Epicea events are created for methods when copying a class"
	<gtExample>
	<noTest>
	| copyClassForm epEntries epEvent |

	self assert: (self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass) isNil
		description: 'Target class already exists'.
	copyClassForm := GtCopyClassForm for: Association.
	copyClassForm newClassName: #GtCopyClassFormExampleCopiedClass.

	epEntries := GtEpiceaEventFactoryExamples epEntriesFrom: 
		[ copyClassForm copyClass.
		(self class environment classOrTraitNamed: #GtCopyClassFormExampleCopiedClass) removeFromSystem ].
	self assert: epEntries isNotEmpty
		description: 'Failed to get entries'.
	epEvent := epEntries first content.
	self assert: epEvent class equals: EpClassAddition.
	self assert: epEvent behaviorAffectedName equals: #GtCopyClassFormExampleCopiedClass.
	self assert: (epEntries select: [ :entry | entry content class = EpMethodAddition ]) size equals: (Association selectors size + Association class selectors size).
]
