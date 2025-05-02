definition-version 1.0

(define-map applicants
  ((id uint))
  ((applicant principal)
   (resume-cid (string-ascii 128))
   (applied-ids (list 20 uint))
   (timestamp uint)))

(define-public (apply-job (app-id uint) (job-id uint) (resume-cid (string-ascii 128)))
  (begin
    (asserts! (is-eq? (map-get? applicants {id: app-id}) none) (err u200))
    (map-insert applicants {id: app-id}
                {applicant: tx-sender, resume-cid: resume-cid, applied-ids: (list job-id), timestamp: (unwrap-panic (get-block-info? block-height))})
    (ok app-id)))
