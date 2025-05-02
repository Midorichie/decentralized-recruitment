definition-version 1.0

(use-trait .applicants applicant-trait)

(define-map jobs
  ((id uint))
  ((employer principal)
   (title (string-ascii 64))
   (description-cid (string-ascii 128))
   (skills (list 10 (string-ascii 32)))
   (timestamp uint)
   (active bool)))

(define-public (post-job (id uint) (title (string-ascii 64)) (desc-cid (string-ascii 128)) (skills (list 10 (string-ascii 32))))
  (begin
    (asserts! (is-eq? (map-get? jobs {id: id}) none) (err u100))
    (map-insert jobs {id: id}
                {employer: tx-sender, title: title, description-cid: desc-cid, skills: skills, timestamp: (unwrap-panic (get-block-info? block-height)), active: true})
    (ok id)))
