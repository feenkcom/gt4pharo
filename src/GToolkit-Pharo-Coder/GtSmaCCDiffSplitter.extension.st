Extension { #name : #GtSmaCCDiffSplitter }

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter class >> forJSON [
	^ self new scannerClass: JSONScanner
]

{ #category : #'*GToolkit-Pharo-Coder' }
GtSmaCCDiffSplitter class >> forPharo [
	^ self new scannerClass: GtPharoScanner
]
