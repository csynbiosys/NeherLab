#include <amigoRHS.h>

#include <math.h>

#include <amigoJAC.h>

#include <amigoSensRHS.h>

#include <amigo_terminate.h>


	/* *** Definition of the states *** */

#define	S_1  Ith(y,0)
#define	E_11 Ith(y,1)
#define	E_12 Ith(y,2)
#define	E_13 Ith(y,3)
#define	I_1  Ith(y,4)
#define	H_1  Ith(y,5)
#define	C_1  Ith(y,6)
#define	R_1  Ith(y,7)
#define	D_1  Ith(y,8)
#define	S_2  Ith(y,9)
#define	E_21 Ith(y,10)
#define	E_22 Ith(y,11)
#define	E_23 Ith(y,12)
#define	I_2  Ith(y,13)
#define	H_2  Ith(y,14)
#define	C_2  Ith(y,15)
#define	R_2  Ith(y,16)
#define	D_2  Ith(y,17)
#define iexp amigo_model->exp_num

	/* *** Definition of the sates derivative *** */

#define	dS_1  Ith(ydot,0)
#define	dE_11 Ith(ydot,1)
#define	dE_12 Ith(ydot,2)
#define	dE_13 Ith(ydot,3)
#define	dI_1  Ith(ydot,4)
#define	dH_1  Ith(ydot,5)
#define	dC_1  Ith(ydot,6)
#define	dR_1  Ith(ydot,7)
#define	dD_1  Ith(ydot,8)
#define	dS_2  Ith(ydot,9)
#define	dE_21 Ith(ydot,10)
#define	dE_22 Ith(ydot,11)
#define	dE_23 Ith(ydot,12)
#define	dI_2  Ith(ydot,13)
#define	dH_2  Ith(ydot,14)
#define	dC_2  Ith(ydot,15)
#define	dR_2  Ith(ydot,16)
#define	dD_2  Ith(ydot,17)

	/* *** Definition of the parameters *** */

#define	Npop     (*amigo_model).pars[0]
#define	R_0      (*amigo_model).pars[1]
#define	epp      (*amigo_model).pars[2]
#define	cosphase (*amigo_model).pars[3]
#define	t_i      (*amigo_model).pars[4]
#define	t_l      (*amigo_model).pars[5]
#define	t_c      (*amigo_model).pars[6]
#define	t_h      (*amigo_model).pars[7]
#define	ze_1     (*amigo_model).pars[8]
#define	m_1      (*amigo_model).pars[9]
#define	c_1      (*amigo_model).pars[10]
#define	f_1      (*amigo_model).pars[11]
#define	ze_2     (*amigo_model).pars[12]
#define	m_2      (*amigo_model).pars[13]
#define	c_2      (*amigo_model).pars[14]
#define	f_2      (*amigo_model).pars[15]
#define M_t	((*amigo_model).controls_v[0][(*amigo_model).index_t_stim]+(t-(*amigo_model).tlast)*(*amigo_model).slope[0][(*amigo_model).index_t_stim])

	/* *** Definition of the algebraic variables *** */

	double	bet;
	double	I_all;
/* Right hand side of the system (f(t,x,p))*/
int amigoRHS(realtype t, N_Vector y, N_Vector ydot, void *data){
	AMIGO_model* amigo_model=(AMIGO_model*)data;
	ctrlcCheckPoint(__FILE__, __LINE__);


	/* *** Equations *** */

	bet=R_0*M_t*(1+epp*cosphase)/t_i;
	I_all=I_1+I_2;
	dS_1=-(1/Npop)*(ze_1*bet)*S_1*(I_all);
	dE_11=(1/Npop)*(ze_1*bet)*S_1*(I_all)-3*E_11/t_l;
	dE_12=3*E_11/t_l-3*E_12/t_l;
	dE_13=3*E_12/t_l-3*E_13/t_l;
	dI_1=3*E_13/t_l-I_1/t_i;
	dH_1=(1-m_1)*I_1/t_l+(1-f_1)*C_1/t_c-H_1/t_h;
	dC_1=c_1*H_1/t_h-C_1/t_c;
	dR_1=m_1*I_1/t_i+(1-c_1)*H_1/t_h;
	dD_1=f_1*C_1/t_c;
	dS_2=-(1/Npop)*(ze_2*bet)*S_2*(I_all);
	dE_21=(1/Npop)*(ze_2*bet)*S_2*(I_all)-3*E_21/t_l;
	dE_22=3*E_21/t_l-3*E_22/t_l;
	dE_23=3*E_22/t_l-3*E_23/t_l;
	dI_2=3*E_23/t_l-I_2/t_i;
	dH_2=(1-m_2)*I_2/t_l+(1-f_2)*C_2/t_c-H_2/t_h;
	dC_2=c_2*H_2/t_h-C_2/t_c;
	dR_2=m_2*I_2/t_i+(1-c_2)*H_2/t_h;
	dD_2=f_2*C_2/t_c;

	return(0);

}


/* Jacobian of the system (dfdx)*/
int amigoJAC(long int N, realtype t, N_Vector y, N_Vector fy, DlsMat J, void *user_data, N_Vector tmp1, N_Vector tmp2, N_Vector tmp3){
	AMIGO_model* amigo_model=(AMIGO_model*)user_data;
	ctrlcCheckPoint(__FILE__, __LINE__);


	return(0);
}

/* R.H.S of the sensitivity dsi/dt = (df/dx)*si + df/dp_i */
int amigoSensRHS(int Ns, realtype t, N_Vector y, N_Vector ydot, int iS, N_Vector yS, N_Vector ySdot, void *data, N_Vector tmp1, N_Vector tmp2){
	AMIGO_model* amigo_model=(AMIGO_model*)data;

	return(0);

}