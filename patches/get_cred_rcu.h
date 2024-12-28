static inline const struct cred *get_cred_rcu(const struct cred *cred)
{
	struct cred *nonconst_cred = (struct cred *) cred;
	if (!cred)
		return NULL;
	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
		return NULL;
	validate_creds(cred);
	return cred;
}
