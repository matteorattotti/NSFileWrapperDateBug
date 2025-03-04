# NSFileWrapper Modification Date Bug

## Overview
This repository demonstrates a bug in `NSFileWrapper` where overwriting a file with the same content using `-[NSFileWrapper writeToURL:options:originalContentsURL:error:]` sometimes causes the file's modification date to be set in the past instead of updating to the current time.

## Reproduction Steps
1. Clone this repository
2. Open the Xcode project and run the `testWriteFile` test.
3. The test should fail ~50% of the times (the test runs 10 times)

## Expected Behavior
When a file is overwritten, its modification date should be updated or kept the same.

## Actual Behavior
The modification date is sometimes set to a past timestamp rather than the actual write time.

## System Information
This issue has been observed on:
- macOS version: 15.4 Beta (24E5206s)
- Xcode version: Version 16.2 (16C5032a)

