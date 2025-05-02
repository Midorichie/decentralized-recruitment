;; Applicants Contract
;; Manages applicant profiles and job applications
 
;; Constants for error codes
(define-constant ERR_APPLICANT_EXISTS u200)
(define-constant ERR_APPLICANT_NOT_FOUND u201)
(define-constant ERR_UNAUTHORIZED u202)
(define-constant ERR_MAX_JOBS_REACHED u203)
(define-constant ERR_INVALID_ID u204)
(define-constant ERR_INVALID_RESUME u205)
(define-constant ERR_INVALID_JOB_ID u206)

;; Applicants map: stores all applicant data
(define-map applicants
  {id: uint}
  {
    applicant: principal,
    resume-cid: (string-ascii 128),
    applied-ids: (list 20 uint),
    timestamp: uint
  }
)

;; Validation functions
(define-private (is-valid-id (id uint))
  (> id u0)
)

(define-private (is-valid-resume (resume-cid (string-ascii 128)))
  (> (len resume-cid) u0)
)

(define-private (is-valid-job-id (job-id uint))
  (> job-id u0)
)
 
;; Apply for a job
(define-public (apply-job (app-id uint) (job-id uint) (resume-cid (string-ascii 128)))
  (begin
    ;; Validate inputs
    (asserts! (is-valid-id app-id) (err ERR_INVALID_ID))
    (asserts! (is-valid-job-id job-id) (err ERR_INVALID_JOB_ID))
    (asserts! (is-valid-resume resume-cid) (err ERR_INVALID_RESUME))
    
    ;; Check if applicant ID already exists
    (asserts! (is-eq (map-get? applicants {id: app-id}) none) (err ERR_APPLICANT_EXISTS))
    
    ;; Insert new applicant
    (map-insert applicants {id: app-id}
                {applicant: tx-sender, 
                 resume-cid: resume-cid, 
                 applied-ids: (list job-id), 
                 timestamp: block-height})
    (ok app-id))
)
 
;; Get applicant details
(define-read-only (get-applicant (id uint))
  (map-get? applicants {id: id})
)
 
;; Apply for additional jobs
(define-public (apply-to-additional-job (app-id uint) (job-id uint))
  (begin
    ;; Validate inputs
    (asserts! (is-valid-id app-id) (err ERR_INVALID_ID))
    (asserts! (is-valid-job-id job-id) (err ERR_INVALID_JOB_ID))
    
    (let ((applicant-data (unwrap! (map-get? applicants {id: app-id}) (err ERR_APPLICANT_NOT_FOUND))))
      ;; Verify ownership
      (asserts! (is-eq tx-sender (get applicant applicant-data)) (err ERR_UNAUTHORIZED))
      
      ;; Check if we still have space in the list
      (asserts! (< (len (get applied-ids applicant-data)) u20) (err ERR_MAX_JOBS_REACHED))
      
      ;; Append job-id to the list and update
      (map-set applicants
               {id: app-id}
               (merge applicant-data
                     {applied-ids: (unwrap-panic (as-max-len? (append (get applied-ids applicant-data) job-id) u20))}))
      (ok true)))
)
